//
//  UpdateTaskspaceTopContentView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 06/01/23.
//

import SwiftUI

struct UpdateTaskspaceTopContentView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    var taskspace: TaskspaceModel
    @Binding var isUpdatingTaskspace: Bool
    var body: some View {
        HStack {
            Button("Cancel") { isUpdatingTaskspace.toggle() }
            Spacer()
            Text(taskspace.name)
                .fontWeight(.semibold)
            Spacer()
            Button("Update") {
                toudouVM.updateTaskspace(taskspace: taskspace)
                isUpdatingTaskspace.toggle()
            }
            .fontWeight(.bold)
        }
    }
}

struct UpdateTaskspaceTopContentView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTaskspaceTopContentView(taskspace: TaskspaceModel(), isUpdatingTaskspace: .constant(false))
    }
}
