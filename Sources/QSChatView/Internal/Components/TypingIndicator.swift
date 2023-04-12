//
//  SwiftUIView.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import SwiftUI

struct TypingIndicator: View {
    let timeInterval: TimeInterval = 0.05
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
                withAnimation() {
                    offset += 0.25
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
