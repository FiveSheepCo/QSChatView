//
//  File.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import Foundation

/// The role of a chat participant.
///
/// Chats usually have one ``chatter``, and one or more ``chattee``s.
public enum ChatParticipantRole: Equatable {
    
    /// The chatter. Think of this as "you".
    /// Usually on the right side of the chat.
    case chatter
    
    /// The chattee. Think of this as "they".
    /// Usually on the left side of the chat.
    case chattee
}

extension ChatParticipantRole {
    
    internal var showOnLeftSide: Bool {
        self == .chattee
    }
}
