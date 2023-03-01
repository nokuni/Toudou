//
//  TaskTitleFieldView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

struct TaskTitleFieldView: View {
    @Binding var title: String
    var focusField: FocusState<FocusField?>.Binding
    var body: some View {
        TextField("Title", text: $title)
            .defaultTextFieldStyle(text: $title, focusField: focusField, focusAction: nil, cancelAction: nil)
            .focused(focusField, equals: .one)
            .limitText(text: $title, limit: 30)
            .submitLabel(.continue)
            .onSubmit { focusField.wrappedValue = .two }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
}
