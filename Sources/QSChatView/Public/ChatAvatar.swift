//
//  File.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import Foundation
import SwiftUI

/// The avatar of a chat participant.
public enum ChatAvatar {
    
    /// An image avatar.
    ///
    /// You should use this whenever possible.
    case image(Image)
    
    /// A type-erased view avatar.
    ///
    /// Supports any view as avatar. Only use this if you have to.
    case any(AnyView)
}

extension ChatAvatar {
    
    /// Get the underlying `View`.
    @ViewBuilder var view: some View {
        switch self {
        case .image(let image):
            image
                .resizable()
                .aspectRatio(1, contentMode: .fit)
        case .any(let view):
            view
        }
    }
}
