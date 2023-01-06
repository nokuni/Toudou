//
//  ViewExtension.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

extension View {
    func defaultTextFieldStyle<Field: RawRepresentable & Hashable>(text: Binding<String>, focusField: FocusState<Field?>.Binding, focusAction: (() -> Void)?, cancelAction: (() -> Void)?) -> some View {
        modifier(TextFieldModifier(text: text, focusField: focusField, focusAction: focusAction, cancelAction: cancelAction))
    }
    
    func editRow(offset: Binding<CGSize>, canDelete: Bool, edit: @escaping () -> Void, delete: @escaping () -> Void, enter: @escaping () -> Void, reset: @escaping () -> Void) -> some View {
        modifier(EditRowModifier(offset: offset, canDelete: canDelete, edit: edit, delete: delete, enter: enter, reset: reset))
    }
}
