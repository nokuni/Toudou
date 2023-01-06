//
//  AddTaskTopContentView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 04/01/23.
//

import SwiftUI

struct AddTaskTopContentView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    var task: TaskModel
    @Binding var isAddingTask: Bool
    var body: some View {
        HStack {
            Button("Cancel") { isAddingTask.toggle() }
            Spacer()
            Text("New Task")
                .fontWeight(.semibold)
            Spacer()
            Button("Add") {
                toudouVM.createTask(task: task)
                NotificationManager.shared.scheduleReminderNotification(of: task)
                NotificationManager.shared.scheduleNotification(of: task)
                isAddingTask.toggle()
            }
            .fontWeight(.bold)
        }
    }
}

struct AddTaskTopContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskTopContentView(task: TaskModel(), isAddingTask: .constant(false))
    }
}
