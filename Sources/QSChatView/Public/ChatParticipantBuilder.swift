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
    private var role: ChatParticipantRole
    private var name: String?
    private var avatar: ChatAvatar?
    private var id: UUID
    
    public init() {
        self.role = .chattee
        self.id = UUID()
    }
    
    /// Assign a specific id to the participant.
    ///
    /// - WARNING: Do not set the `id` manually, unless you know exactly what you're doing.
    ///
    /// - NOTE: It's usually totally fine to let `QSChatView` handle `id` creation and management.
    /// If you need this, it's probably because you want to serialize and deserialize participants directly
    /// and need the ids to be in sync between sessions for bookkeeping purposes. We're working on a
    /// better way of handling such scenarios, but for now this option is there to fill the gap.
    public func withId(_ id: UUID) -> Self {
        self.id = id
        return self
    }
    
    /// Assign a specific role to the participant.
    ///
    /// - WARNING: Do not set the `role` manually, unless you know exactly what you're doing.
    ///
    /// - NOTE: In almost all scenarios, participants should have the ``ChatParticipantRole/chattee`` role.
    /// If you need a participant with the `chatter` role, you're probably looking for ``ChatParticipant/me``.
    public func withRole(_ role: ChatParticipantRole) -> Self {
        self.role = role
        return self
    }
    
    /// Assign a name to the participant.
    public func withName(_ name: String?) -> Self {
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
            avatar: avatar,
            id: id
        )
    }
}
