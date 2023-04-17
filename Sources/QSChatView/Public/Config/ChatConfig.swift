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
    
    /// Configure chat bubble context menu items
    @Published public var contextMenuItems: Set<ChatContextMenuItem>
    
    init(
        showTimestamps: Bool,
        showTextField: Bool,
        scrollingBehavior: ChatScrollBehavior,
        contextMenuItems: Set<ChatContextMenuItem>
    ) {
        self.showTimestamps = showTimestamps
        self.showTextField = showTextField
        self.scrollingBehavior = scrollingBehavior
        self.contextMenuItems = [.deleteMessage]
    }
}

extension ChatConfig {
    public static var `default`: ChatConfig {
        ChatConfig(
            showTimestamps: true,
            showTextField: true,
            scrollingBehavior: .adaptive,
            contextMenuItems: [.deleteMessage]
        )
    }
}
