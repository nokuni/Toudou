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
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea()
                VStack {
                    
                    if !toudouVM.tasks.isEmpty {
                        FilterSegmentedPicker(models: TaskFiltering.allCases, selectedModel: $toudouVM.filtering)
                    }
                    
                    TaskListView()
                    
                }
            }
            .navigationTitle("To Do")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    SortingButtonView()
                }
                
                ToolbarItem(placement: .principal) {
                    SortOrderButtonView()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NewTaskButtonView()
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
