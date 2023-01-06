//
//  JoinTaskspaceTopContentView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 05/01/23.
//

import SwiftUI

struct JoinTaskspaceTopContentView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    var taskspace: TaskspaceModel
    @Binding var isJoining: Bool
    var body: some View {
        HStack {
            Button("Cancel") {
                isJoining.toggle()
            }
            Spacer()
            Text("Join Taskspace")
                .fontWeight(.semibold)
            Spacer()
            Button("Join") {
                toudouVM.joinTaskspace(with: taskspace.name, and: taskspace.password)
                isJoining.toggle()
            }
            .fontWeight(.bold)
        }
    }
}

struct JoinTaskspaceTopContentView_Previews: PreviewProvider {
    static var previews: some View {
        JoinTaskspaceTopContentView(taskspace: TaskspaceModel(), isJoining: .constant(false))
    }
}
