//
//  SwiftUIView.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import SwiftUI

struct ChatBubble: View {
    var participant: ChatParticipant
    var display: ChatBubbleDisplay
    
    /// Raw chat content based on ``ChatBubbleDisplay``.
    @ViewBuilder private var rawContent: some View {
        switch display {
        case .text(let content, let timestamp):
            HStack(alignment: .center, spacing: 15) {
                Text(content)
                if let timestamp = timestamp {
                    VStack {
                        Spacer()
                        Text(timestamp.formatted(date: .omitted, time: .shortened))
                            .font(.footnote)
                            .opacity(0.5)
                    }
                }
            }.fixedSize(horizontal: false, vertical: true)
        case .loading:
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
            if let avatar = participant.avatar, participant.role == .chattee {
                avatar
                    .view
                    .frame(width: 24, height: 24)
                    .clipShape(Circle())
                    .offset(y: -2.5) // visual balance
            }
            rawContent
                .padding(.horizontal, 20)
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
            if (participant.role.showOnLeftSide) {
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
                participant: other,
                display: .text(
                    "Hi",
                    time: Date(timeIntervalSince1970: 1680307200)
                )
            )
            ChatBubble(
                participant: me,
                display: .text(
                    "What's up?",
                    time: Date(timeIntervalSince1970: 1680308700)
                )
            )
            ChatBubble(
                participant: other,
                display: .loading
            )
        }.padding()
    }
}
