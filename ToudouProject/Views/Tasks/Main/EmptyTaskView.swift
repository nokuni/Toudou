//
//  EmptyTaskView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/03/23.
//

import SwiftUI

struct EmptyTaskView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    var body: some View {
        VStack(spacing: 0) {
            Image("emptyTaskImage")
                .resizable()
                .scaledToFit()
            Button(action: {
                toudouVM.isTaskAdding.toggle()
            }) {
                Text("Create a new task")
                    .fontWeight(.medium)
                    .font(.title2)
                    .foregroundColor(.accentColor)
            }
        }
        .padding()
    }
}

struct EmptyTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyTaskView()
    }
}
