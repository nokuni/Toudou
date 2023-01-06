//
//  ContentView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI
import CoreData

struct TasksView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    @State private var isAddingTask: Bool = false
    @State private var isAddingCategory: Bool = false
    @State private var sorting: TaskSorting = .all
    @State private var allowReordering = true
    @State private var isUpdatingTask: Bool = false
    @State private var selectedTask: TaskEntity?
    var body: some View {
        NavigationView {
            ZStack {
                if let _ = toudouVM.selectedTaskspace {
                    VStack {
                        
                        TaskTopButtonsView(isAddingCategory: $isAddingCategory)

                        FilterSegmentedPicker(models: TaskSorting.allCases, selectedModel: $sorting)
                            .padding(.bottom)
                        ScrollView {
                            ForEach(toudouVM.filteredTasks(sorting: sorting).indices, id: \.self) { index in
                                TaskRowView(task: toudouVM.filteredTasks(sorting: sorting)[index], selectedTask: $selectedTask, offset: $toudouVM.taskOffsets[index], isUpdatingTask: $isUpdatingTask)
                                    .padding(.vertical, 5)
                            }
                        }
                        .animation(.none)
                    }
                    .padding()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                withAnimation {
                                    toudouVM.toggleTaskEditMode()
                                }
                            }) {
                                HStack {
                                    Text(toudouVM.isOnEditMode ? "Cancel" : "Edit")
                                }
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                isAddingTask.toggle()
                            }) {
                                HStack {
                                    Text("New Task")
                                    Image(systemName: "note.text.badge.plus")
                                }
                            }
                        }
                        ToolbarItem(placement: .principal) {
                            HStack {
                                Button(action: {
                                    toudouVM.sortTaskByPriority(on: false)
                                }) {
                                    Image(systemName: "arrow.up")
                                        .fontWeight(.black)
                                        .foregroundColor(.redApp)
                                }
                                
                                Button(action: {
                                    toudouVM.sortTaskByPriority(on: true)
                                }) {
                                    Image(systemName: "arrow.up")
                                        .fontWeight(.black)
                                        .foregroundColor(.greenApp)
                                }
                            }
                        }
                    }
                    .sheet(isPresented: $isAddingTask) {
                        AddTaskView(isAddingTask: $isAddingTask)
                    }
                    .sheet(isPresented: $isUpdatingTask) {
                        TaskDetailView(isUpdatingTask: $isUpdatingTask, selectedTask: $selectedTask)
                    }
                    .sheet(isPresented: $isAddingCategory) {
                        AddCategoryView(isAddingCategory: $isAddingCategory)
                    }
                    .onAppear {
                        toudouVM.fetchTasks()
                        toudouVM.fetchTaskCategories()
                        toudouVM.setUpTaskOffsets()
                    }
                } else {
                    VStack {
                        Image("taskspace.image")
                            .resizable()
                            .scaledToFit()
                        Text("You have no selected taskplace.")
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    }
                }
            }
            .navigationTitle(toudouVM.taskspaceTitle)
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
