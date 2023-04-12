//
//  SwiftUIView.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import SwiftUI

/// An animated typing indicator.
///
/// - Note: The default values are well-optimized.
struct TypingIndicator: View {
    let timeInterval: TimeInterval = 0.2
    let offsetChangePerTimeStep: Double = 1.0
    
    let heightMultiplier: Double = 1.5
    let innerSpacing: Double = 7.5
    
    @State private var offset: Double = 0
    @State private var timer: Timer?
    
    var body: some View {
        HStack(alignment: .center, spacing: innerSpacing) {
            Text(".")
                .offset(y: -(sin(offset + 0) + 1) * heightMultiplier)
            Text(".")
                .offset(y: -(sin(offset + 2) + 1) * heightMultiplier)
            Text(".")
                .offset(y: -(sin(offset + 4) + 1) * heightMultiplier)
        }
        .onAppear {
            timer?.invalidate()
            timer = Timer.scheduledTimer(
                withTimeInterval: timeInterval,
                repeats: true
            ) { _ in
                withAnimation(.linear(duration: timeInterval)) {
                    offset += offsetChangePerTimeStep
                }
            }
        }
    }
}

struct TypingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        TypingIndicator()
    }
}
