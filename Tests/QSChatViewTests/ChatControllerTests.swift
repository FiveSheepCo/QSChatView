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
    
    func testSend() throws {
        let participant = ChatParticipant.mockChatter
        let message = ChatMessage(from: participant, content: .text("Foo"))
        let controller = ChatController()
        
        controller.send(message)
        
        let firstMessage = controller.messages.first
        XCTAssertNotNil(firstMessage)
        XCTAssertEqual(firstMessage!, message)
    }
    
    func testSendPromiseFulfill() throws {
        let participant = ChatParticipant.mockChatter
        let controller = ChatController()
        
        let promise = controller.sendPromise(from: participant)
        
        ({
            let firstMessage = controller.messages.first
            XCTAssertNotNil(firstMessage)
            XCTAssertEqual(firstMessage!.content, .typingIndicator)
        }())
        
        promise.fulfill(withContent: .text("Foo"))
        
        ({
            let firstMessage = controller.messages.first
            XCTAssertNotNil(firstMessage)
            XCTAssertEqual(firstMessage!.content, .text("Foo"))
        }())
    }
    
    func testSendPromiseReject() throws {
        let participant = ChatParticipant.mockChatter
        let controller = ChatController()
        
        let promise = controller.sendPromise(from: participant)
        
        ({
            let firstMessage = controller.messages.first
            XCTAssertNotNil(firstMessage)
            XCTAssertEqual(firstMessage!.content, .typingIndicator)
        }())
        
        promise.reject()
        
        ({
            let firstMessage = controller.messages.first
            XCTAssertNil(firstMessage)
        }())
    }
}
