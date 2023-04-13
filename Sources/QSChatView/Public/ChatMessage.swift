//
//  File.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import Foundation

/// A chat message.
public struct ChatMessage: Equatable, Identifiable {
    let participant: ChatParticipant
    private(set) var content: ChatMessageContent
    private(set) var timestamp: Date
    
    // MARK: - Internal Interface
    
    mutating func replaceContent(with content: ChatMessageContent, timestamp: Date? = nil) {
        self.content = content
        self.timestamp = timestamp ?? self.timestamp
    }
    
    var displayTimeStamp: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: timestamp)
    }
    
    // MARK: - Public Interface
    
    public init(from participant: ChatParticipant, content: ChatMessageContent, timestamp: Date = Date()) {
        self.participant = participant
        self.content = content
        self.timestamp = timestamp
    }
    
    // MARK: - Identifiable
    
    public let id: UUID = UUID()
}
