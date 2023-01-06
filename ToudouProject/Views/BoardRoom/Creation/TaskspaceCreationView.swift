//
//  TaskspaceCreationView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 05/01/23.
//

import SwiftUI

struct TaskspaceCreationView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    @State private var taskspace = TaskspaceModel()
    @FocusState var focusField: FocusField?
    @Binding var isCreating: Bool
    var body: some View {
        NavigationView {
            ZStack {
                Color.yingYang.ignoresSafeArea()
            VStack(spacing: 30) {
                CreationTaskspaceTopContentView(taskspace: taskspace, isCreating: $isCreating)
                
                Image("taskspaceCreation.image")
                    .resizable()
                    .scaledToFit()
                
                CreationTaskspaceNameFieldView(taskspace: $taskspace, focusField: $focusField)
                
                CreationTaskspacePasswordFieldView(taskspace: $taskspace, focusField: $focusField)
                
                Spacer()
            }
            .padding()
        }
    }
    }
}

struct TaskspaceCreationView_Previews: PreviewProvider {
    static var previews: some View {
        TaskspaceCreationView(isCreating: .constant(false))
    }
}
