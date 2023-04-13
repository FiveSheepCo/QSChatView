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
    
    public func fulfill(withContent content: ChatMessageContent, timestamp: Date? = nil) {
        controller.fulfill(self, withContent: content, timestamp: timestamp)
    }
}
