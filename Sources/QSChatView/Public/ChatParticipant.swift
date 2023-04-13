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
    let name: String?
    let avatar: ChatAvatar?
    let role: ChatParticipantRole
    
    // MARK: - Internal Interface
    
    init(role: ChatParticipantRole, name: String? = nil, avatar: ChatAvatar? = nil) {
        self.name = name
        self.avatar = avatar
        self.role = role
    }
    
    // MARK: - Identifiable
    
    public let id: UUID = UUID()
    
    // MARK: - Equatable
    
    public static func == (lhs: ChatParticipant, rhs: ChatParticipant) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.role == rhs.role
    }
}
