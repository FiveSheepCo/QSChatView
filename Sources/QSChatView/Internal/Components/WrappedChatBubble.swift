//
//  SwiftUIView.swift
//  
//
//  Created by SplittyDev on 17.04.23.
//

import SwiftUI

struct WrappedChatBubble: View {
    @ObservedObject var controller: ChatController
    
    let message: ChatMessage
    let onMessageDeleted: (ChatMessage) -> Void
    
    var chatBubbleTransition: AnyTransition {
        if #available(iOS 16.0, macOS 13.0, *) {
            return AnyTransition.push(from: .bottom)
        } else {
            return AnyTransition.opacity
        }
    }
    
    var body: some View {
        ChatBubble(
            message,
            edgeDistance: 50,
            config: controller.config
        )
        .contextMenu {
            ForEach(Array(controller.config.contextMenuItems), id: \.self) { item in
                switch item {
                case .deleteMessage:
                    Button(role: .destructive) {
                        withAnimation {
                            controller.delete(id: message.id)
                        }
                        onMessageDeleted(message)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .transition(chatBubbleTransition)
    }
}

struct WrappedChatBubble_Previews: PreviewProvider {
    static let mockController = ChatController()
    
    static let mockMessage = ChatMessage(
        from: .me,
        content: .text("Hello world")
    )
    
    static var previews: some View {
        WrappedChatBubble(
            controller: mockController,
            message: mockMessage,
            onMessageDeleted: {_ in}
        ).padding()
    }
}
