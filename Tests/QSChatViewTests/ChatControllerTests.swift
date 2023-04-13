//
//  ChatControllerTests.swift
//  
//
//  Created by SplittyDev on 13.04.23.
//

import XCTest
@testable import QSChatView

fileprivate extension ChatParticipant {
    static var mockChatter: ChatParticipant {
        ChatParticipantBuilder(as: .chatter).withName("Alice").build()
    }
    
    static var mockChattee: ChatParticipant {
        ChatParticipantBuilder(as: .chattee).withName("Bob").build()
    }
}

final class ChatControllerTests: XCTestCase {
    func testInit() throws {
        let _ = ChatController()
    }
    
    func testInitWithMessages() throws {
        let participant = ChatParticipant.mockChatter
        let messages = [
            ChatMessage(from: participant, content: .text("Foo")),
            ChatMessage(from: participant, content: .text("Bar")),
        ]
        let _ = ChatController(with: messages)
    }
}
