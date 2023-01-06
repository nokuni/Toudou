//
//  TaskspaceRowView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 05/01/23.
//

import SwiftUI

struct TaskspaceRowView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    var taskspace: TaskspaceEntity
    @Binding var offset: CGSize
    @Binding var isUpdatingTaskspace: Bool
    @Binding var isShowingAlert: Bool
    @Binding var taskspaceManagementError: TaskspaceManagementError
    var body: some View {
        Button(action: {
            toudouVM.selectedTaskspace = taskspace
        }) {
            Color.yingYang
                .cornerRadius(10)
                .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.1, maxHeight: UIScreen.main.bounds.height * 0.1)
                .background(Color.yingYang.cornerRadius(10))
                .overlay(TaskspaceRowContentView(taskspace: taskspace))
                .editRow(
                    offset: $offset,
                    canDelete: taskspace.isOwning,
                    edit: {
                        if taskspace.isOwning {
                            isUpdatingTaskspace.toggle()
                        } else {
                            taskspaceManagementError = .contributorEdit
                            isShowingAlert.toggle()
                        }
                    },
                    delete: {
                        isShowingAlert.toggle()
                        if taskspace.isOwning {
                            taskspaceManagementError = .ownerDelete
                        } else {
                            taskspaceManagementError = .contributorDelete
                        }
                    },
                    enter: {
                        
                    },
                    reset: {
                        
                    })
        }
    }
}

struct TaskspaceRowView_Previews: PreviewProvider {
    static var previews: some View {
        TaskspaceRowView(taskspace: TaskspaceEntity(), offset: .constant(CGSize.zero), isUpdatingTaskspace: .constant(false), isShowingAlert: .constant(false), taskspaceManagementError: .constant(.contributorDelete))
    }
}
