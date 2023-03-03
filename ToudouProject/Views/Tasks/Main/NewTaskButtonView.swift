//
//  NewTaskButtonView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/03/23.
//

import SwiftUI

struct NewTaskButtonView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    var body: some View {
        if !toudouVM.tasks.isEmpty {
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
}
