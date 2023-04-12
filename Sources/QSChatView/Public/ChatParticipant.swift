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
public struct ChatParticipant: Identifiable, Equatable {
    public let id: UUID = UUID()
    let name: String?
    let avatar: ChatAvatar?
    let role: ChatParticipantRole
    
    // Equatable
    public static func == (lhs: ChatParticipant, rhs: ChatParticipant) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.role == rhs.role
    }
}
