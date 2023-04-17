import SwiftUI
import Combine

public struct QSChatView: View {
    @StateObject private var controller: ChatController
    @StateObject private var scrollView = ScrollViewData()
    
    @State private var lastSeenMessageId: UUID?
    @State private var unseenMessageCount = 0
    
    let onMessageSent: (String) -> Void
    let onMessageDeleted: (ChatMessage) -> Void
    
    public init(
        _ controller: ChatController?,
        onMessageSent: @escaping (String) -> Void = {_ in},
        onMessageDeleted: @escaping (ChatMessage) -> Void = {_ in}
    ) {
        self._controller = StateObject(wrappedValue: controller ?? ChatController())
        self.onMessageSent = onMessageSent
        self.onMessageDeleted = onMessageDeleted
    }
    
    var scrollIndicatorTransition: AnyTransition {
        if #available(iOS 16.0, macOS 13.0, *) {
            return AnyTransition.push(from: .bottom)
        } else {
            return AnyTransition.opacity
        }
    }
    
    func updateUnseenMessages(_ messages: [ChatMessage]) {
        if scrollView.isScrolledToBottom {
            unseenMessageCount = 0
        } else if let lastSeenMessageIndex = messages.firstIndex(where: { $0.id == lastSeenMessageId }) {
            let lastIndex = messages.endIndex - 1
            unseenMessageCount = lastIndex - lastSeenMessageIndex
        }
    }
    
    func adjustScrollPosition(_ messages: [ChatMessage]) {
        guard let lastMessage = messages.last else { return }
        
        switch controller.config.scrollingBehavior {
        case .always:
            scrollView.scrollTo(lastMessage.id, anchor: .bottom)
            break
        case .adaptive where scrollView.isScrolledToBottom:
            scrollView.scrollTo(lastMessage.id, anchor: .bottom)
        default:
            break
        }
    }
    
    public var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                
                // Chat View
                BetterScrollView(data: scrollView) {
                    LazyVStack(spacing: 15) {
                        
                        // Render all messages as chat bubbles
                        ForEach(controller.messages) { message in
                            WrappedChatBubble(
                                controller: controller,
                                message: message,
                                onMessageDeleted: onMessageDeleted
                            )
                        }
                        .animation(
                            .easeOut(duration: 0.15),
                            value: controller.messages
                        )
                    }
                    .onChange(of: scrollView.isScrolledToBottom, perform: { newValue in
                        guard !newValue else { return }
                        guard let lastMessage = controller.messages.last else { return }
                        lastSeenMessageId = lastMessage.id
                    })
                    .onChange(of: controller.messages, perform: { newValue in
                        withAnimation {
                            updateUnseenMessages(newValue)
                            adjustScrollPosition(newValue)
                        }
                    })
                }
                
                // ScrollToBottom/UnseenMessages Indicator
                ZStack {
                    if !scrollView.isScrolledToBottom {
                        HStack(alignment: .center) {
                            if unseenMessageCount > 0 {
                                ZStack(alignment: .center) {
                                    Circle()
                                        .foregroundColor(.secondary)
                                    Text("\(unseenMessageCount)")
                                }
                                .frame(width: 24, height: 24)
                            }
                            Image(systemName: "chevron.down")
                        }
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            guard let lastMessage = controller.messages.last else { return }
                            scrollView.scrollTo(lastMessage.id, anchor: .bottom)
                            unseenMessageCount = 0
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.primary.opacity(0.05), lineWidth: 1)
                        )
                        .shadow(radius: 5, x: 0, y: 2)
                    }
                }
                .offset(x: -10, y: -20)
                .transition(scrollIndicatorTransition)
                .animation(.easeInOut(duration: 0.25), value: unseenMessageCount)
            }
            
            if controller.config.showTextField {
                ChatTextField() { content in
                    onMessageSent(content)
                    controller.send(
                        ChatMessage(
                            from: .me,
                            content: .text(content),
                            timestamp: Date()
                        )
                    )
                }
            }
        }
    }
}

struct QSChatView_Previews: PreviewProvider {
    static var timer: Timer? = nil
    
    static var dummyConversation: [String] {
        [
            "Hey! How's your day going?",
            "Pretty good, just got back from work. How about you?",
            "Just finished a workout, feeling pumped! 💪",
            "Nice! What did you work on today?",
            "Mostly legs, some squats and lunges. My legs are going to be sore tomorrow!",
            "Haha, I can imagine. I did a leg day last week and couldn't walk properly for two days 😂",
            "Oh no 😂 That's the worst but also the best feeling!",
            "Yeah, it's a love-hate relationship with leg day. Got any plans for the evening?",
            "I'm thinking about watching a movie, any recommendations?",
            "Sure! Have you seen \"The Shape of Water\"? It's a bit older but really good.",
            "No, I haven't. Sounds interesting, I'll give it a try! Thanks!",
            "You're welcome! Let me know what you think of it.",
            "Will do! What are your plans for the weekend?",
            "Going hiking with a few friends. The weather's supposed to be great.",
            "Oh, that sounds like fun! Where are you going?",
            "We're heading to the Pine Mountain Trail, it's beautiful this time of year.",
            "That sounds amazing, I'm a bit jealous. Have a great time!",
            "Thanks, I'm really looking forward to it. You have a great weekend too!",
            "Thanks, I will! Catch you later! 👋",
            "Bye! Enjoy the movie! 🍿",
        ]
    }
    
    // This is quite the convoluted preview setup, but it's needed
    // in order to test various aspects of the chat behavior.
    static var previews: some View {
        var offset = 0
        let chatter = ChatParticipant.me
        let chattee = ChatParticipantBuilder().withAvatarImage(Image(systemName: "person.crop.circle")).build()
        let controller = ChatController(messages: [
            .init(from: chatter, content: .image(Image(systemName: "hand.thumbsup.fill")))
        ])
        var startTimestamp: TimeInterval = 1681429800 - 60 * 60 * 2
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            if offset == dummyConversation.count {
                timer.invalidate()
                return
            }
            DispatchQueue.main.async {
                let participant = offset % 2 == 0 ? chattee : chatter
                let promise = controller.sendPromise(from: participant)
                let content = ChatMessageContent.text(dummyConversation[offset])
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                    DispatchQueue.main.async {
                        controller.fulfill(promise, withContent: content, timestamp: Date(timeIntervalSince1970: startTimestamp))
                        startTimestamp += 60 * 2
                    }
                }
                offset += 1
            }
        }
        return QSChatView(controller)
            .padding()
    }
}
