//
//  AddCategoryNameFieldView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 05/01/23.
//

import SwiftUI

struct AddCategoryNameFieldView: View {
    @Binding var taskCategory: TaskCategory
    var focusField: FocusState<FocusField?>.Binding
    var body: some View {
        TextField("Title", text: $taskCategory.name)
            .defaultTextFieldStyle(text: $taskCategory.name, focusField: focusField, focusAction: nil, cancelAction: nil)
            .focused(focusField, equals: .one)
            .submitLabel(.done)
            .onAppear { taskCategory.name = "" }
    }
}
