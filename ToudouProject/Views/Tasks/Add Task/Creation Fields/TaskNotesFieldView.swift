//
//  TaskNotesFieldView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

struct TaskNotesFieldView: View {
    @Binding var task: TaskModel
    var focusField: FocusState<FocusField?>.Binding
    var body: some View {
        
        TextField("Notes", text: $task.notes, axis: .vertical)
            .padding()
            .frame(height: UIScreen.main.bounds.height * 0.1, alignment: .topLeading)
            .background(Color(UIColor.systemGray5).cornerRadius(8))
            .focused(focusField, equals: .three)
            .submitLabel(.return)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
}
