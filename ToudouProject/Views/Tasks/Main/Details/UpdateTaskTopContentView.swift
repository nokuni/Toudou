//
//  UpdateTaskTopContentView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 06/01/23.
//

import SwiftUI

struct UpdateTaskTopContentView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    var task: TaskModel
    @Binding var isUpdatingTask: Bool
    var body: some View {
        HStack {
            Button("Cancel") { isUpdatingTask.toggle() }
            Spacer()
            Text(task.title)
                .fontWeight(.semibold)
            Spacer()
            Button("Update") {
                toudouVM.updateTask(task: task)
                isUpdatingTask.toggle()
            }
            .fontWeight(.bold)
        }
    }
}

struct UpdateTaskTopContentView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTaskTopContentView(task: TaskModel(), isUpdatingTask: .constant(false))
    }
}
