//
//  SwiftUIView.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import SwiftUI

/// A stylized `TextField` for chat input.
struct ChatTextField: View {
    private let prompt: String
    @Binding private var text: String
    
    init(_ text: Binding<String>, prompt: String = "") {
        self._text = text
        self.prompt = prompt
    }
    
    var promptView: Text {
        Text(prompt)
    }
    
    var textFieldStyle: ChatTextFieldStyle<Material> {
        ChatTextFieldStyle(background: .thinMaterial)
    }
    
    @ViewBuilder var innerTextField: some View {
        TextField("", text: $text, prompt: promptView)
    }
    
    @ViewBuilder var compatibleTextField: some View {
        if #available(iOS 16.0, *) {
            innerTextField
                .textFieldStyle(textFieldStyle)
                .scrollDismissesKeyboard(.interactively)
        } else {
            innerTextField
                .textFieldStyle(textFieldStyle)
        }
    }
    
    @ViewBuilder var sendButton: some View {
        Circle()
            .frame(width: 32, height: 32)
            .background(.thinMaterial)
            .clipShape(Circle())
            .overlay(alignment: .center) {
                Image(systemName: "paperplane.fill")
                    .rotationEffect(.degrees(45))
                    .font(.system(size: 20))
                    .offset(x: -2)
            }
            .contentShape(Rectangle())
    }
    
    var body: some View {
        HStack {
            compatibleTextField
            sendButton
        }
    }
}

struct ChatTextField_Previews: PreviewProvider {
    static var previews: some View {
        ChatTextField(.constant("Test"))
            .padding()
    }
}
