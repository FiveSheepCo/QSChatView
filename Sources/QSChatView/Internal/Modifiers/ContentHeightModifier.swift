//
//  File.swift
//  
//
//  Created by SplittyDev on 14.04.23.
//

import Foundation
import SwiftUI

struct ContentHeightModifier: ViewModifier {
    let coordinateSpace: String
    @Binding var contentHeight: Double

    func body(content: Content) -> some View {
        ZStack {
            content
            GeometryReader { proxy in
                Color.clear
                    .preference(
                        key: ContentHeightPreferenceKey.self,
                        value: proxy.frame(in: .named(coordinateSpace)).maxY
                    )
            }
        }
        .onPreferenceChange(ContentHeightPreferenceKey.self) { value in
            contentHeight = value
        }
    }
}
