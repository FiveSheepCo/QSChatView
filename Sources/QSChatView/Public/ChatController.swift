//
//  File.swift
//  
//
//  Created by SplittyDev on 13.04.23.
//

import Foundation
import SwiftUI

/// The chat controller used by ``QSChatView``.
public class ChatController: ObservableObject {
    @Published var textInputContent: String = ""
    @Published var messages: [ChatMessage] = []
    
    // MARK: - Internal Interface
    
    /// Fulfill a ``ChatMessagePromise``, replacing the contents of the original message.
    func fulfill(
        _ promise: ChatMessagePromise,
        withContent content: ChatMessageContent,
        timestamp: Date? = nil
    ) {
        guard let messageId = messages.firstIndex(where: { $0.id == promise.messageId }) else { return }
        messages[messageId].replaceContent(with: content, timestamp: timestamp)
    }
    
    // MARK: - Public Interface
    
    /// Create a new instance of ``ChatController``
    public init(with messages: [ChatMessage] = []) {
        self.messages = messages
    }
    
    /// Send a ``ChatMessage``
    public func send(_ message: ChatMessage) {
        messages.append(message)
    }
    
    /// Send a temporary ``ChatMessage`` with a loading indicator.
    ///
    /// Use ``ChatController/fulfill(_:withContent:timestamp:)`` to replace the message contents later.
    public func sendPromise(from participant: ChatParticipant) -> ChatMessagePromise {
        let message = ChatMessage(from: participant, content: .typingIndicator)
        self.send(message)
        return ChatMessagePromise(controller: self, messageId: message.id)
    }
}
