//
//  JoinTaskspaceNameFieldView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 05/01/23.
//

import SwiftUI

struct JoinTaskspaceNameFieldView: View {
    @Binding var taskspace: TaskspaceModel
    var focusField: FocusState<FocusField?>.Binding
    var body: some View {
        TextField("Name", text: $taskspace.name)
            .defaultTextFieldStyle(text: $taskspace.name, focusField: focusField, focusAction: nil, cancelAction: nil)
            .focused(focusField, equals: .one)
            .submitLabel(.continue)
            .onSubmit { focusField.wrappedValue = .two }
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
}
