//
//  File.swift
//  
//
//  Created by SplittyDev on 14.04.23.
//

import Foundation

/// The promise of a chat message to be fulfilled later.
///
/// Use via ``ChatController/sendPromise(from:)``
public struct ChatMessagePromise {
    let controller: ChatController
    let messageId: UUID
    
    // MARK: - Internal Interface
    
    init(controller: ChatController, messageId: UUID) {
        self.controller = controller
        self.messageId = messageId
    }
    
    // MARK: - Public Interface
    
    /// Fulfill the message promise.
    ///
    /// Replaces the loading indicator of the promised message with its final content.
    public func fulfill(withContent content: ChatMessageContent, timestamp: Date = Date()) {
        controller.fulfill(self, withContent: content, timestamp: timestamp)
    }
    
    /// Reject the message promise.
    ///
    /// Removes the promised message from the chat.
    public func reject() {
        controller.reject(self)
    }
}
