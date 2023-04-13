import SwiftUI

public struct QSChatView: View {
    @StateObject var controller: ChatController
    
    var chatBubbleTransition: AnyTransition {
        if #available(iOS 16.0, *) {
            return AnyTransition.push(from: .bottom)
        } else {
            return AnyTransition.opacity
        }
    }
    
    public var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView(.vertical) {
                    ForEach(controller.messages) { message in
                        ChatBubble(
                            message,
                            edgeDistance: 50
                        )
                        .transition(chatBubbleTransition)
                        Spacer(minLength: 15)
                    }
                    .animation(.default, value: controller.messages)
                }
                .onChange(of: controller.messages, perform: { newValue in
                    guard let lastMessage = newValue.last else { return }
                    withAnimation {
                        scrollView.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                })
            }
            Spacer()
            ChatTextField($controller.textInputContent)
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
    
    static var previews: some View {
        var offset = 0
        let chatter = ChatParticipantBuilder(as: .chatter).build()
        let chattee = ChatParticipantBuilder(as: .chattee).withAvatarImage(Image(systemName: "person.crop.circle")).build()
        let controller = ChatController(with: [
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
        return QSChatView(controller: controller)
            .padding()
    }
}
