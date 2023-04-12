//
//  SwiftUIView.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import SwiftUI

struct ChatBubble: View {
    var message: ChatMessage
    
    init(_ message: ChatMessage) {
        self.message = message
    }
    
    /// Raw chat content based on ``ChatBubbleDisplay``.
    @ViewBuilder private var rawContent: some View {
        switch message.content {
        case .text(let content):
            HStack(alignment: .center, spacing: 15) {
                Text(content)
                VStack {
                    Spacer()
                    Text(message.displayTimeStamp)
                        .font(.footnote)
                        .opacity(0.5)
                }
            }.fixedSize(horizontal: false, vertical: true)
        case .image(let image):
            VStack {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
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
                Spacer()
            } else {
                Spacer()
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
    
    static var previews: some View {
        VStack {
            ChatBubble(
                ChatMessage(
                    from: other,
                    content: .text("Hi"),
                    timestamp: Date(timeIntervalSince1970: 1680307200)
                )
            )
            ChatBubble(
                ChatMessage(
                    from: me,
                    content: .text("What's up?"),
                    timestamp: Date(timeIntervalSince1970: 1680308700)
                )
            )
            ChatBubble(
                ChatMessage(
                    from: other,
                    content: .typingIndicator
                )
            )
        }.padding()
    }
}
