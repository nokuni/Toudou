//
//  TaskRowView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

struct TaskRowView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    var task: TaskEntity
    @Binding var selectedTask: TaskEntity?
    @Binding var offset: CGSize
    @Binding var isUpdatingTask: Bool
    var body: some View {
        Button(action: {
            selectedTask = task
            isUpdatingTask.toggle()
        }) {
            HStack {
                if !task.isDone {
                    ValidateButtonView(task: task)
                }
                HStack {
                    
                    Spacer()
                    
                    if let title = task.title {
                        Text(title)
                            .foregroundColor(task.isDone ? .secondary : .yangYing)
                            .strikethrough(task.isDone, color: .secondary)
                    }
                    
                    Spacer()
                    
                    if let categoryName = task.category {
                        Image(TaskModel.categoryIcon(from: toudouVM.taskCategories, categoryName: categoryName))
                            .resizable()
                            .frame(width: UIScreen.main.bounds.height * 0.03, height: UIScreen.main.bounds.height * 0.03)
                            .opacity(task.isDone ? 0.2 : 1)
                    }
                }
                .padding(8)
                .background(Color.yingYang.cornerRadius(10))
            }
            .editRow(
                offset: $offset, canDelete: true,
                edit: {
                    isUpdatingTask.toggle()
                },
                delete: {
                    toudouVM.deleteTask(task: task)
                },
                enter: {
                    toudouVM.toggleTaskEditMode()
                },
                reset: {
                    toudouVM.toggleTaskEditMode()
                })
        }
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        TaskRowView(task: TaskEntity(), selectedTask: .constant(TaskEntity()), offset: .constant(.zero), isUpdatingTask: .constant(false))
    }
}
