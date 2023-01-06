//
//  JoinTaskspacePasswordFieldView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 05/01/23.
//

import SwiftUI

struct JoinTaskspacePasswordFieldView: View {
    @Binding var taskspace: TaskspaceModel
    var focusField: FocusState<FocusField?>.Binding
    var body: some View {
        SecureField("Password", text: $taskspace.password)
            .defaultTextFieldStyle(text: $taskspace.password, focusField: focusField, focusAction: nil, cancelAction: nil)
            .focused(focusField, equals: .two)
            .submitLabel(.done)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
}
