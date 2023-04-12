//
//  File.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import Foundation
import SwiftUI

struct ChatTextFieldStyle<S>: TextFieldStyle where S: ShapeStyle {
    private let background: S
    
    init(background: S) {
        self.background = background
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(self.background)
            )
    }
}
