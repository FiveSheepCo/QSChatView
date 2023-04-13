//
//  File.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import Foundation
import SwiftUI

/// A ``ChatParticipant`` builder.
///
/// Allows easy creation of chat participants.
public class ChatParticipantBuilder {
    private let role: ChatParticipantRole
    private var name: String?
    private var avatar: ChatAvatar?
    
    public init(as role: ChatParticipantRole) {
        self.role = role
    }
    
    /// Assign a name to the participant.
    public func withName(_ name: String) -> Self {
        self.name = name
        return self
    }
    
    /// Assign an avatar image to the participant.
    public func withAvatarImage(_ image: Image) -> Self {
        self.avatar = .image(image)
        return self
    }
    
    /// Assign an avatar view to the participant.
    ///
    /// **This uses type erasure.** Using ``withAvatarImage(_:)`` is preferred.
    public func withAvatarView(_ view: some View) -> Self {
        self.avatar = .any(AnyView(view))
        return self
    }
    
    /// Build the ``ChatParticipant``.
    public func build() -> ChatParticipant {
        ChatParticipant(
            role: role,
            name: name,
            avatar: avatar
        )
    }
}
