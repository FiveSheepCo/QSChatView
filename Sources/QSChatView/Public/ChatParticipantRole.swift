//
//  File.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import Foundation

public enum ChatParticipantRole: Equatable {
    case chatter
    case chattee
    
    internal var showOnLeftSide: Bool {
        self == .chattee
    }
}
