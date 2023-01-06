//
//  BoardRoomView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 05/01/23.
//

import SwiftUI

enum TaskspaceManagementError {
    case none, contributorEdit, ownerDelete, contributorDelete
}

struct BoardRoomView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    @State private var sorting: TaskspaceBelonging = .all
    @State private var isJoining: Bool = false
    @State private var isCreating: Bool = false
    @State private var isUpdatingTaskspace: Bool = false
    @State private var isShowingAlert: Bool = false
    @State private var taskspaceManagementError: TaskspaceManagementError = .none
    
    var alertErrorTitle: String {
        switch taskspaceManagementError {
        case .none: return ""
        case .contributorEdit: return "Authorization denied"
        case .ownerDelete: return "Delete Taskspace"
        case .contributorDelete: return "Authorization denied"
        }
    }
    var alertErrorContent: String {
        switch taskspaceManagementError {
        case .none: return ""
        case .contributorEdit: return "You don't have the authorization to edit this taskspace."
        case .ownerDelete: return "Do you really want to delete this taskspace ? All tasks related will be also deleted."
        case .contributorDelete: return "You don't have the authorization to delete this taskspace."
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                FilterSegmentedPicker(models: TaskspaceBelonging.allCases, selectedModel: $sorting)
                    .padding(.bottom)
                ScrollView {
                    ForEach(toudouVM.filteredTaskspaces(sorting: sorting).indices, id: \.self) { index in
                        TaskspaceRowView(taskspace: toudouVM.filteredTaskspaces(sorting: sorting)[index], offset: $toudouVM.taskspaceOffsets[index], isUpdatingTaskspace: $isUpdatingTaskspace, isShowingAlert: $isShowingAlert, taskspaceManagementError: $taskspaceManagementError)
                            .alert(alertErrorTitle, isPresented: $isShowingAlert) {
                                let isOwning = toudouVM.filteredTaskspaces(sorting: sorting)[index].isOwning
                                Button("Cancel", role: .cancel) { }
                                if isOwning && taskspaceManagementError == .ownerDelete {
                                    Button("Delete", role: .destructive) {
                                        toudouVM.deleteTaskspace(taskspace: toudouVM.filteredTaskspaces(sorting: sorting)[index])
                                    }
                                }
                            }
                    }
                }
                .animation(.none)
            }
            .padding()
            .navigationTitle("Boardroom")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        withAnimation {
                            isJoining.toggle()
                        }
                    }) {
                        HStack {
                            Text("Join Taskspace")
                            Image(systemName: "rectangle.portrait.and.arrow.forward.fill")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isCreating.toggle()
                    }) {
                        HStack {
                            Text("Create Taskspace")
                            Image(systemName: "rectangle.fill.badge.plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $isJoining) {
                JoinTaskspaceView(isJoining: $isJoining)
            }
            .sheet(isPresented: $isCreating) {
                TaskspaceCreationView(isCreating: $isCreating)
            }
            .sheet(isPresented: $isUpdatingTaskspace) {
                TaskspaceDetailView(isUpdatingTaskspace: $isUpdatingTaskspace)
            }
        }
    }
}

struct BoardRoomView_Previews: PreviewProvider {
    static var previews: some View {
        BoardRoomView()
    }
}
