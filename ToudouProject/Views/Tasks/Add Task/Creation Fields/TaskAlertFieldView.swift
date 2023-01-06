//
//  TaskAlertFieldView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 06/01/23.
//

import SwiftUI

struct TaskAlertFieldView: View {
    @Binding var task: TaskModel
    @Binding var selectedAlert: TaskAlertReminder
    var body: some View {
        Menu {
            ForEach(TaskAlertReminder.allCases, id: \.self) { alert in
                Button(action: {
                    selectedAlert = alert
                    task.reminder = selectedAlert
                }) {
                    Text(alert.rawValue)
                        .padding()
                        .background(Color.blue)
                }
                .buttonStyle(.borderedProminent)
            }
        } label: {
            HStack {
                Text("Alert")
                    .foregroundColor(.primary)
                Spacer()
                Text(selectedAlert.rawValue)
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
        TaskAlertFieldView(task: .constant(TaskModel()), selectedAlert: .constant(.onTime))
    }
}
