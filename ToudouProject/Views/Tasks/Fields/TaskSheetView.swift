//
//  TaskSheetView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

struct TaskSheetView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    @FocusState var focusField: FocusField?
    @State var taskModel = TaskModel()
    @State var selectedAlert: TaskAlertReminder = .none
    var body: some View {
        NavigationView {
            ZStack {
                Color.yingYang.ignoresSafeArea()
                VStack(spacing: 30) {
                    AddTaskTopContentView(taskModel: taskModel)
                    
                    ScrollView(showsIndicators: false) {
                        
                        VStack(spacing: 12) {
                            
                            TaskTitleFieldView(title: $taskModel.title, focusField: $focusField)
                            
                            TaskPriorityFieldView(priority: $taskModel.priority)
                                .padding(.horizontal)
                            
                            Toggle("Due date", isOn: $taskModel.hasDueDate)
                                .padding(.horizontal)
                            
                            TaskDateFieldView(dueDate: $taskModel.dueDate)
                                .padding(.horizontal)
                                .disabled(!taskModel.hasDueDate)
                            
                            TaskAlertFieldView(taskModel: $taskModel)
                                .disabled(!taskModel.hasDueDate)
                            
                            TaskCategoryFieldView(category: $taskModel.category)
                            
                            TaskNotesFieldView(notes: $taskModel.notes, focusField: $focusField)
                            
                            Spacer()
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                if !toudouVM.isEditing {
                    if let selectedTask = toudouVM.selectedTask {
                        toudouVM.isEditing = true
                        taskModel.title = selectedTask.title
                        taskModel.hasDueDate = selectedTask.dueDate != nil
                        taskModel.dueDate = selectedTask.dueDate ?? Date.now
                        taskModel.category = selectedTask.category
                        taskModel.priority = selectedTask.priority
                        taskModel.reminder = selectedTask.reminder
                        taskModel.notes = selectedTask.notes
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    switch true {
                    case focusField == .one:
                        Text("\(taskModel.title.count) / 30 characters")
                    case focusField == .two:
                        Text("\(taskModel.notes.count) / 300 characters")
                    default:
                        Text("Unknown item")
                    }
                }
            }
        }
    }
}

struct TaskSheetView_Previews: PreviewProvider {
    static var previews: some View {
        TaskSheetView()
    }
}
