//
//  SwiftUIView.swift
//  
//
//  Created by SplittyDev on 12.04.23.
//

import SwiftUI

/// A stylized `TextField` for chat input.
struct ChatTextField: View {
    typealias OnSubmitHandler = (String) -> Void
    
    private let prompt: String
    private let onSubmit: OnSubmitHandler
    @State private var text: String = ""
    
    init(prompt: String = "", onSubmit: @escaping OnSubmitHandler = { _ in }) {
        self.prompt = prompt
        self.onSubmit = onSubmit
    }
    
    var promptView: Text {
        Text(prompt)
    }
    
    var textFieldStyle: ChatTextFieldStyle<Material> {
        ChatTextFieldStyle(background: .thinMaterial)
    }
    
    func onSubmitInner() {
        guard !text.isEmpty else { return }
        
        onSubmit(text)
        text = ""
    }
    
    @ViewBuilder var innerTextField: some View {
        TextField("", text: $text, prompt: promptView)
    }
    
    @ViewBuilder var compatibleTextField: some View {
        if #available(iOS 16.0, macOS 13.0, *) {
            innerTextField
                .textFieldStyle(textFieldStyle)
                .scrollDismissesKeyboard(.interactively)
        } else {
            innerTextField
                .textFieldStyle(textFieldStyle)
        }
    }
    
    @ViewBuilder var sendButton: some View {
        Image(systemName: "paperplane.circle.fill")
            .rotationEffect(.degrees(45))
            .font(.system(size: 26))
            .foregroundColor(.primary)
            .contentShape(Rectangle())
    }
    
    var body: some View {
        HStack {
            compatibleTextField
                .onSubmit(onSubmitInner)
            sendButton
                .onTapGesture(perform: onSubmitInner)
        }
    }
}

struct ChatTextField_Previews: PreviewProvider {
    static var previews: some View {
        ChatTextField()
            .padding()
    }
}
