//
//  File.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import Foundation

public struct ChatMessage: Equatable, Identifiable {
    public let id: UUID = UUID()
    
    let participant: ChatParticipant
    let content: ChatMessageContent
    let timestamp: Date
    
    public init(from participant: ChatParticipant, content: ChatMessageContent, timestamp: Date = Date()) {
        self.participant = participant
        self.content = content
        self.timestamp = timestamp
    }
    
    internal var displayTimeStamp: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: timestamp)
    }
}
