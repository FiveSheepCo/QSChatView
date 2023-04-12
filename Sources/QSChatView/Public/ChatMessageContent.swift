//
//  File.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import Foundation
import SwiftUI

public enum ChatMessageContent: Equatable {
    case typingIndicator
    case text(String)
    case image(Image)
}
