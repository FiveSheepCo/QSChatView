//
//  File.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import Foundation

/// Display mode for a chat bubble.
///
/// Make sure to handle future @unknown cases.
public enum ChatBubbleDisplay {
    /// Display text in the chat bubble.
    ///
    /// Supports an optional date/time.
    case text(_ content: String, time: Date? = nil)
    
    /// Display a loading indicator in the chat bubble.
    case loading
}
