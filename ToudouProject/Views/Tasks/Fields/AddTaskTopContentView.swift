//
//  AddTaskTopContentView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 04/01/23.
//

import SwiftUI

struct AddTaskTopContentView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    var taskModel: TaskModel
    var body: some View {
        SheetTopContentView(title: "New Task",
                            contextualLabel: toudouVM.selectedTask == nil ? "Create" : "Edit",
                            isContextualActionDisabled: taskModel.title.isEmpty) {
            if toudouVM.selectedTask == nil {
                toudouVM.createTask(taskModel: taskModel)
                toudouVM.isTaskAdding.toggle()
            } else {
                toudouVM.updateTask(taskModel: taskModel)
                toudouVM.isTaskEditing.toggle()
            }
        } dismissAction: {
            if toudouVM.isEditing {
                toudouVM.isTaskEditing.toggle()
            } else {
                toudouVM.isTaskAdding.toggle()
            }
        }
    }
}

struct AddTaskTopContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskTopContentView(taskModel: TaskModel())
    }
}
