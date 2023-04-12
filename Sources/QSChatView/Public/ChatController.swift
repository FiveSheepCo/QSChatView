//
//  File.swift
//  
//
//  Created by SplittyDev on 13.04.23.
//

import Foundation
import SwiftUI

public class ChatController: ObservableObject {
    @Published var textInputContent: String = ""
    @Published var messages: [ChatMessage] = []
    
    public init(with messages: [ChatMessage] = []) {
        self.messages = messages
    }
}
