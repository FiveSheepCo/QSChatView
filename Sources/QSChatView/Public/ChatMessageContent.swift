//
//  File.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import Foundation
import SwiftUI

/// The content of a chat message.
public enum ChatMessageContent: Equatable {
    
    /// A typing indicator.
    ///
    /// Used for pending messages.
    case typingIndicator
    
    /// A simple text message.
    case text(String)
    
    /// An image.
    case image(Image)
}

extension ChatMessageContent {
    var isText: Bool {
        textContent != .none
    }
    
    var textContent: String? {
        if case .text(let string) = self {
            return string
        }
        return nil
    }
}
