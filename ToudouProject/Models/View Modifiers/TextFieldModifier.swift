//
//  TextFieldModifier.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

enum FocusField: String {
    case one, two, three, four, five, six, seven, eight, nine, ten
}

struct TextFieldModifier<Field: RawRepresentable & Hashable>: ViewModifier {
    var text: Binding<String>
    var focusField: FocusState<Field?>.Binding
    var focusAction: (() -> Void)?
    var cancelAction: (() -> Void)?
    
    init(text: Binding<String>, focusField: FocusState<Field?>.Binding, focusAction: (() -> Void)?, cancelAction: (() -> Void)?) {
        self.text = text
        self.focusField = focusField
        self.focusAction = focusAction
        self.cancelAction = cancelAction
    }
    
    func body(content: Content) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .foregroundColor(Color(UIColor.systemGray5))
            .frame(maxWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height * 0.05, maxHeight: UIScreen.main.bounds.height * 0.05)
            .overlay(
                HStack {
                    content
                    if !text.wrappedValue.isEmpty {
                        Button(action: {
                            self.text.wrappedValue = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                        }
                        .foregroundColor(.blue)
                    }
                    if focusField.wrappedValue != nil {
                        Button("Cancel") {
                            withAnimation {
                                cancelAction?()
                                focusField.wrappedValue = nil
                            }
                        }
                        .foregroundColor(.blue)
                    }
                }
                    .padding(.horizontal)
            )
            .onChange(of: focusField.wrappedValue) { _ in
                if focusField.wrappedValue != nil { focusAction?() }
            }
    }
}
