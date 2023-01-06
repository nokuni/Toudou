//
//  JoinTaskspaceView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 05/01/23.
//

import SwiftUI

struct JoinTaskspaceView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    @State var taskspace = TaskspaceModel()
    @Binding var isJoining: Bool
    @FocusState var focusField: FocusField?
    var body: some View {
        NavigationView {
            ZStack {
                Color.yingYang.ignoresSafeArea()
                VStack(spacing: 30) {
                    JoinTaskspaceTopContentView(taskspace: taskspace, isJoining: $isJoining)
                    
                    Image("taskspaceJoining.image")
                        .resizable()
                        .scaledToFit()
                    
                    JoinTaskspaceNameFieldView(taskspace: $taskspace, focusField: $focusField)
                    
                    JoinTaskspacePasswordFieldView(taskspace: $taskspace, focusField: $focusField)
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct JoinTaskspaceView_Previews: PreviewProvider {
    static var previews: some View {
        JoinTaskspaceView(isJoining: .constant(false))
    }
}
