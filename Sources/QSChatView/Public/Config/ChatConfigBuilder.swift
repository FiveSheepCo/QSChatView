//
//  File.swift
//  
//
//  Created by SplittyDev on 17.04.23.
//

import Foundation

/// A ``ChatConfig`` builder.
///
/// Allows easy creation of a custom chat configuration.
public class ChatConfigBuilder {
    let config = ChatConfig.default
    
    public init() {}
    
    public func showTimestamps(_ value: Bool = true) -> Self {
        config.showTimestamps = value
        return self
    }
    
    public func showTextField(_ value: Bool = true) -> Self {
        config.showTextField = value
        return self
    }
    
    public func withScrollingBehavior(_ value: ChatScrollBehavior) -> Self {
        config.scrollingBehavior = value
        return self
    }
    
    public func withContextMenuItems(_ items: Set<ChatContextMenuItem>) -> Self {
        config.contextMenuItems = items
        return self
    }
    
    public func build() -> ChatConfig {
        config
    }
}
