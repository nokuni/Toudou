//
//  TaskListView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 28/02/23.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    @State var isAlertingForDelete: Bool = false
    var body: some View {
        List {
            if toudouVM.tasks.isEmpty {
                EmptyTaskView()
            } else {
                ForEach(toudouVM.filteredTasks(), id: \.self) { task in
                    NavigationLink(destination: TaskDetailView(task: task)) {
                        TaskRowView(task: task)
                            .swipeActions {
                                Button("Delete") {
                                    if task.isDone {
                                        withAnimation {
                                            toudouVM.deleteTask(task)
                                        }
                                    } else {
                                        isAlertingForDelete = true
                                    }
                                }
                                .tint(.red)
                            }
                            .confirmationDialog(
                                Text("This task is still active. Do you really want to delete this task ?"),
                                isPresented: $isAlertingForDelete,
                                titleVisibility: .visible
                            ) {
                                Button("Delete", role: .destructive) {
                                    withAnimation {
                                        toudouVM.deleteTask(task)
                                    }
                                }
                            }
                    }
                }
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
