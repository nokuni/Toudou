//
//  TaskTitleFieldView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

struct TaskTitleFieldView: View {
    @Binding var task: TaskModel
    var focusField: FocusState<FocusField?>.Binding
    var body: some View {
        TextField("Title", text: $task.title)
            .defaultTextFieldStyle(text: $task.title, focusField: focusField, focusAction: nil, cancelAction: nil)
            .focused(focusField, equals: .one)
            .submitLabel(.continue)
            .onSubmit { focusField.wrappedValue = .two }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
}
