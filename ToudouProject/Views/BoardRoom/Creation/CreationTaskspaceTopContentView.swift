//
//  CreationTaskspaceTopContentView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 05/01/23.
//

import SwiftUI

struct CreationTaskspaceTopContentView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    var taskspace: TaskspaceModel
    @Binding var isCreating: Bool
    var body: some View {
        HStack {
            Button("Cancel") {
                isCreating.toggle()
            }
            Spacer()
            Text("Create Taskspace")
                .fontWeight(.semibold)
            Spacer()
            Button("Create") {
                toudouVM.createTaskspace(taskspace: taskspace)
                isCreating.toggle()
            }
            .fontWeight(.bold)
        }
    }
}

struct CreationTaskspaceTopContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreationTaskspaceTopContentView(taskspace: TaskspaceModel(), isCreating: .constant(false))
    }
}
