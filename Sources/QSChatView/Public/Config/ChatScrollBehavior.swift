//
//  File.swift
//  
//
//  Created by SplittyDev on 15.04.23.
//

import Foundation

/// Automatic chat scrolling behavior.
public enum ChatScrollBehavior {
    
    /// Always scroll to bottom when new messages arrive
    case always
    
    /// Never scroll to bottom when new messages arrive
    case never
    
    /// Automatically scroll to bottom when new messages arrive,
    /// but only if the scroll position is already near the bottom.
    ///
    /// - NOTE: This is the recommended behavior.
    case adaptive
}
