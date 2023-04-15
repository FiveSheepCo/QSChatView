//
//  File.swift
//  
//
//  Created by SplittyDev on 15.04.23.
//

import Foundation

public class ChatConfig: ObservableObject {
    
    /// Show timestamps on chat messages
    @Published public var showTimestamps: Bool
    
    /// Show an interactive text field to let the user send messages
    @Published public var showTextField: Bool
    
    /// Automatic chat scrolling behavior
    @Published public var scrollingBehavior: ChatScrollBehavior
    
    init(showTimestamps: Bool, showTextField: Bool, scrollingBehavior: ChatScrollBehavior) {
        self.showTimestamps = showTimestamps
        self.showTextField = showTextField
        self.scrollingBehavior = scrollingBehavior
    }
}

extension ChatConfig {
    public static var `default`: ChatConfig {
        ChatConfig(
            showTimestamps: true,
            showTextField: true,
            scrollingBehavior: .adaptive
        )
    }
}
