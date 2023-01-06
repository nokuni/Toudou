//
//  TaskPriorityFieldView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

struct TaskPriorityFieldView: View {
    @Binding var task: TaskModel
    var body: some View {
        HStack {
            Text("Priority")
            ColoredSegmentedPicker(models: TaskModel.Priority.allCases, selectedModel: $task.priority)
        }
        .padding(.leading)
    }
}

struct TaskPriorityFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TaskPriorityFieldView(task: .constant(TaskModel()))
    }
}
