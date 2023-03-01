//
//  ViewExtension.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

extension View {
    func defaultTextFieldStyle<Field: RawRepresentable & Hashable>(
        text: Binding<String>,
        focusField: FocusState<Field?>.Binding,
        focusAction: (() -> Void)?,
        cancelAction: (() -> Void)?
    ) -> some View {
        modifier(TextFieldModifier(text: text, focusField: focusField, focusAction: focusAction, cancelAction: cancelAction))
    }
    
    func limitText(text: Binding<String>, limit: Int) -> some View {
        modifier(TextLimiterModifier(text: text, limit: limit))
    }
}
