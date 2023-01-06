//
//  TaskDateFieldView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

struct TaskDateFieldView: View {
    @Binding var task: TaskModel
    var body: some View {
        DatePicker(selection: $task.date, in: Date()...) {
            Text("Date")
        }
        .padding(.leading)
//        DatePicker("Date", selection: $task.date)
//            .padding(.leading)
    }
}

struct TaskDateFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDateFieldView(task: .constant(TaskModel()))
    }
}
