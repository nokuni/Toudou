//
//  ContentView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI
import CoreData

extension Bool: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = value != 0
    }
}

enum SortOrder: Bool {
    
    case ascending
    case descending
    
    mutating func toggle() {
        self = self == .ascending ? .descending : .ascending
    }
    
    var description: String {
        switch self {
        case .ascending:
            return "Ascending"
        case .descending:
            return "Descending"
        }
    }
}

struct TasksView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    @State private var filtering: TaskFiltering = .all
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {
                    
                    // The ShareLink shows a security message "This method should not be called on the main thread as it may lead to UI unresponsiveness.". This is a known issue. It can be ignored.
                    ShareButtonView()
                    
                    FilterSegmentedPicker(models: TaskFiltering.allCases, selectedModel: $filtering)
                    
                    TaskListView(filtering: $filtering)
                    
                }
            }
            .navigationTitle("To Do")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Menu("Sort") {
                            ForEach(TaskSorting.allCases, id: \.self) { sort in
                                Button(action: {
                                    toudouVM.selectedSort = sort
                                    toudouVM.readTasks()
                                }) {
                                    HStack {
                                        Text(sort.rawValue)
                                        if toudouVM.selectedSort == sort {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    
                    Button(action: {
                        toudouVM.switchSortOrder()
                    }) {
                        HStack {
                            Text("\(toudouVM.sortOrder.description.capitalized)")
                            Image(systemName: toudouVM.sortOrder.rawValue ? "arrow.down" : "arrow.up")
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        toudouVM.isTaskAdding.toggle()
                    }) {
                        HStack {
                            Text("New Task")
                            Image(systemName: "note.text.badge.plus")
                        }
                    }
                }
            }
            .onAppear {
                toudouVM.selectedTask = nil
            }
            .sheet(isPresented: $toudouVM.isTaskAdding, onDismiss: {
                toudouVM.isEditing = false
            }) {
                TaskSheetView()
            }
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
