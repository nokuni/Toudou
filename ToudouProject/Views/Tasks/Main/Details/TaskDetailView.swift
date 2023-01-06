//
//  TaskDetailView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 06/01/23.
//

import SwiftUI

struct TaskDetailView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    @State var task = TaskModel()
    @FocusState var focusField: FocusField?
    @Binding var isUpdatingTask: Bool
    @Binding var selectedTask: TaskEntity?
    @State var selectedAlert: TaskAlertReminder = .none
    var body: some View {
        NavigationView {
            ZStack {
                Color.yingYang.ignoresSafeArea()
                VStack(spacing: 30) {
                    UpdateTaskTopContentView(task: task, isUpdatingTask: $isUpdatingTask)
                    
                    ScrollView {
                        
                        VStack(spacing: 12) {
                            
                            TaskTitleFieldView(task: $task, focusField: $focusField)
                            
                            TaskPlaceFieldView(task: $task, focusField: $focusField)
                            
                            TaskPriorityFieldView(task: $task)
                            
                            TaskCategoryFieldView(taskCategory: $task.category)
                            
                            TaskNotesFieldView(task: $task, focusField: $focusField)
                            
                            Spacer()
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                if let selectedTask = selectedTask {
                    if let id = selectedTask.id { task.id = id }
                    task.title = selectedTask.title ?? ""
                    task.place = selectedTask.place ?? ""
                    task.category.name = selectedTask.category ?? ""
                    if let priorityNumber = TaskModel.Priority.allCases.first(where: {
                        return $0.rawValue == selectedTask.priority
                    }) {
                        task.priority = priorityNumber
                    }
                    task.notes = selectedTask.notes ?? ""
                }
            }
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(isUpdatingTask: .constant(false), selectedTask: .constant(TaskEntity()))
    }
}
