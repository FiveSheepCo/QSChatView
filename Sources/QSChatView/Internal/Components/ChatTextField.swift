//
//  SwiftUIView.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import SwiftUI

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
    
    var innerTextField: some View {
        TextField("", text: $text, prompt: promptView)
    }
    
    var textFieldStyle: ChatTextFieldStyle<Material> {
        ChatTextFieldStyle(background: .thinMaterial)
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            innerTextField
                .textFieldStyle(textFieldStyle)
                .scrollDismissesKeyboard(.interactively)
        } else {
            innerTextField
                .textFieldStyle(textFieldStyle)
        }
    }
}

struct ChatTextField_Previews: PreviewProvider {
    static var previews: some View {
        ChatTextField(.constant("Test"))
            .padding()
    }
}
