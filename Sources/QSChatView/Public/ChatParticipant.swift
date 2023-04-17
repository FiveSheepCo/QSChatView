//
//  File.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import Foundation
import SwiftUI

/// A chat participant.
///
/// You should use ``ChatParticipantBuilder`` to instantiate this.
public class ChatParticipant: Identifiable, Equatable {
    @available(*, deprecated, message: "Use ChatParticipant.me instead.")
    public static let defaultChatter = ChatParticipant(role: .chatter)
    
    /// A chat participant representing the current user.
    public static let me = ChatParticipant(role: .chatter)
    
    let name: String?
    let avatar: ChatAvatar?
    let role: ChatParticipantRole
    
    // MARK: - Internal Interface
    
    init(role: ChatParticipantRole, name: String? = nil, avatar: ChatAvatar? = nil, id: UUID = UUID()) {
        self.name = name
        self.avatar = avatar
        self.role = role
        self.id = id
    }
    
    // MARK: - Identifiable
    
    public let id: UUID
    
    // MARK: - Equatable
    
    public static func == (lhs: ChatParticipant, rhs: ChatParticipant) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.role == rhs.role
    }
}
