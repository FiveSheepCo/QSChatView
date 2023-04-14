//
//  File.swift
//  
//
//  Created by SplittyDev on 14.04.23.
//

import Foundation
import SwiftUI

struct ScrollOffsetModifier: ViewModifier {
    let coordinateSpace: String
    @Binding var offset: Double

    func body(content: Content) -> some View {
        ZStack {
            content
            GeometryReader { proxy in
                Color.clear
                    .preference(
                        key: ScrollOffsetPreferenceKey.self,
                        value: -proxy.frame(in: .named(coordinateSpace)).minY
                    )
            }
        }
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
            offset = value
        }
    }
}
