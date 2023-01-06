//
//  AddTaskView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    @State var task = TaskModel()
    @FocusState var focusField: FocusField?
    @Binding var isAddingTask: Bool
    @State var selectedAlert: TaskAlertReminder = .none
    var body: some View {
        NavigationView {
            ZStack {
                Color.yingYang.ignoresSafeArea()
                VStack(spacing: 30) {
                    AddTaskTopContentView(task: task, isAddingTask: $isAddingTask)
                    
                    ScrollView {
                        
                        VStack(spacing: 12) {
                            
                            TaskTitleFieldView(task: $task, focusField: $focusField)
                            
                            TaskPlaceFieldView(task: $task, focusField: $focusField)
                            
                            TaskDateFieldView(task: $task)
                            
                            TaskPriorityFieldView(task: $task)
                            
                            TaskAlertFieldView(task: $task, selectedAlert: $selectedAlert)
                            
                            TaskCategoryFieldView(taskCategory: $task.category)
                            
                            TaskNotesFieldView(task: $task, focusField: $focusField)
                            
                            Spacer()
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(isAddingTask: .constant(false))
    }
}
