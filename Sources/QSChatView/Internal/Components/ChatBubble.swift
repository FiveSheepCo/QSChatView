//
//  SwiftUIView.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import SwiftUI

struct ChatBubble: View {
    var message: ChatMessage
    var edgeDistance: Double
    
    @ObservedObject var config: ChatConfig
    
    init(_ message: ChatMessage, edgeDistance: Double, config: ChatConfig) {
        self.message = message
        self.edgeDistance = edgeDistance
        self.config = config
    }
    
    #if os(iOS)
    var timestampColor: UIColor {
        UIColor.label.withAlphaComponent(0.5)
    }
    #elseif os(macOS)
    var timestampColor: NSColor {
        NSColor.labelColor.withAlphaComponent(0.5)
    }
    #endif
    
    private var timestampStr: AttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        paragraphStyle.lineBreakMode = .byWordWrapping
        var str = AttributedString(stringLiteral: message.displayTimeStamp)
        str.foregroundColor = timestampColor
        str.paragraphStyle = paragraphStyle
        str.font = .footnote
        return str
    }
    
    private var showTimestampOnSameLine: Bool {
        message.content.isText
        && message.content.textContent?.count ?? 0 < 25
    }
    
    /// Raw chat content based on ``ChatBubbleDisplay``.
    @ViewBuilder private var rawContent: some View {
        switch message.content {
        case .text(let content):
            if config.showTimestamps {
                if showTimestampOnSameLine {
                    HStack(alignment: .bottom) {
                        Text(content)
                        Text(timestampStr)
                    }
                } else {
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(content)
                            .fixedSize(horizontal: false, vertical: true)
                        Text(timestampStr)
                    }
                }
            } else {
                Text(content)
            }
        case .image(let image):
            VStack(alignment: .trailing, spacing: 4) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(5)
                    .padding()
                if config.showTimestamps {
                    Text(timestampStr)
                }
            }
        case .typingIndicator:
            HStack(alignment: .center, spacing: 15) {
                TypingIndicator()
            }
        }
    }
    
    /// Styled content based on `rawContent`.
    ///
    /// This adds avatars, padding, backgrounds, etc.
    @ViewBuilder private var styledContent: some View {
        HStack(alignment: .bottom, spacing: 10) {
            if let avatar = message.participant.avatar, message.participant.role == .chattee {
                avatar
                    .view
                    .frame(width: 24, height: 24)
                    .clipShape(Circle())
                    .offset(y: -2.5) // visual balance
            }
            rawContent
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(.thinMaterial)
                .cornerRadius(10)
        }
    }
    
    /// Positioned content based on `styledContent`.
    ///
    /// This positions the chat bubble on the horizontal axis.
    @ViewBuilder private var positionedContent: some View {
        HStack(alignment: .center, spacing: 0) {
            if (message.participant.role.showOnLeftSide) {
                styledContent
                Spacer(minLength: edgeDistance)
            } else {
                Spacer(minLength: edgeDistance)
                styledContent
            }
        }
    }
    
    var body: some View {
        positionedContent
    }
}

struct ChatBubble_Previews: PreviewProvider {
    static var me: ChatParticipant {
        ChatParticipantBuilder(as: .chatter)
            .withName("Splitty")
            .build()
    }
    
    static var other: ChatParticipant {
        ChatParticipantBuilder(as: .chattee)
            .withName("Eel")
            .withAvatarView(
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.black, .teal)
            )
            .build()
    }
    
    static var config: ChatConfig {
        let config = ChatConfig.default
        // config.showTimestamps = false
        return config
    }
    
    static var previews: some View {
        VStack {
            ChatBubble(
                ChatMessage(
                    from: other,
                    content: .text("Hi"),
                    timestamp: Date(timeIntervalSince1970: 1680307200)
                ),
                edgeDistance: 50,
                config: config
            )
            ChatBubble(
                ChatMessage(
                    from: me,
                    content: .text("What's up? Long text to test wrapping"),
                    timestamp: Date(timeIntervalSince1970: 1680308700)
                ),
                edgeDistance: 50,
                config: config
            )
            ChatBubble(
                ChatMessage(
                    from: me,
                    content: .text("Short text"),
                    timestamp: Date(timeIntervalSince1970: 1680308700)
                ),
                edgeDistance: 50,
                config: config
            )
            ChatBubble(
                ChatMessage(
                    from: me,
                    content: .image(Image(systemName: "hand.thumbsup.fill")),
                    timestamp: Date(timeIntervalSince1970: 1680308700)
                ),
                edgeDistance: 50,
                config: config
            )
            ChatBubble(
                ChatMessage(
                    from: other,
                    content: .typingIndicator
                ),
                edgeDistance: 50,
                config: config
            )
        }.padding()
    }
}
