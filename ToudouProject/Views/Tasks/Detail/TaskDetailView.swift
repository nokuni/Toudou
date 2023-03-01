//
//  TaskDetailView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 06/01/23.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var toudouVM: ToudouViewModel
    @ObservedObject var task: TaskEntity
    @StateObject var dateTimer = DateTimer()
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 15) {
                
                TaskCategoryAndTitleView(task: task)
                
                TaskDatesView(task: task)
                
                TaskNotesView(task: task)
                
                TaskCountdownView(size: geometry.size, task: task, dateTimer: dateTimer)
                
                if task.isDone {
                    InvalidateTaskButtonView(task: task)
                } else {
                    EditAndValidateTaskButtonView(task: task)
                }
            }
        }
        .sheet(isPresented: $toudouVM.isTaskEditing, onDismiss: {
            toudouVM.isEditing = false
            toudouVM.selectedTask = task
            if let dueDate = toudouVM.selectedTask?.dueDate {
                dateTimer.start(with: dueDate)
            }
        }) {
            TaskSheetView()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(task.title)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                ShareButtonView(task: task)
            }
        }
        .onAppear {
            toudouVM.selectedTask = task
            if let dueDate = task.dueDate {
                dateTimer.start(with: dueDate)
            }
        }
        .padding(.horizontal)
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(task: TaskEntity(context: CoreDataManager.shared.container.viewContext))
    }
}
