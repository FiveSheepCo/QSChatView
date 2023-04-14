//
//  File.swift
//  
//
//  Created by SplittyDev on 14.04.23.
//

import Foundation
import SwiftUI

struct ContentHeightPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}
