//
//  TaskPlaceFieldView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

struct TaskPlaceFieldView: View {
    @Binding var task: TaskModel
    var focusField: FocusState<FocusField?>.Binding
    var body: some View {
        HStack {
            TextField("Place", text: $task.place)
                .defaultTextFieldStyle(text: $task.place, focusField: focusField, focusAction: nil, cancelAction: nil)
                .focused(focusField, equals: .two)
                .submitLabel(.continue)
                .onSubmit { focusField.wrappedValue = .three }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            
            Menu {
                ForEach(TaskModel.Priority.allCases, id: \.self) {
                    Text($0.name)
                }
            } label: {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: UIScreen.main.bounds.height * 0.05, height: UIScreen.main.bounds.height * 0.05)
                    .overlay(
                        Image(systemName: "wand.and.stars.inverse")
                    )
            }
        }
    }
}
