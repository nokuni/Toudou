//
//  TaskAlertFieldView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 06/01/23.
//

import SwiftUI

struct TaskAlertFieldView: View {
    @Binding var taskModel: TaskModel
    var body: some View {
        Menu {
            ForEach(TaskAlertReminder.allCases, id: \.self) { reminder in
                Button(action: {
                    taskModel.reminder = reminder
                }) {
                    Text(reminder.rawValue)
                        .padding()
                        .background(Color.blue)
                }
                .disabled(taskModel.isReminderPossible(on: reminder))
                .buttonStyle(.borderedProminent)
            }
        } label: {
            HStack {
                Text("Reminder")
                    .foregroundColor(.primary)
                Spacer()
                Text(taskModel.reminder.rawValue)
                Image(systemName: "chevron.up.chevron.down")
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.05, maxHeight: UIScreen.main.bounds.height * 0.05)
            .background(Color(UIColor.systemGray5).cornerRadius(10))
        }
    }
}

struct TaskAlertFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TaskAlertFieldView(taskModel: .constant(TaskModel()))
    }
}
