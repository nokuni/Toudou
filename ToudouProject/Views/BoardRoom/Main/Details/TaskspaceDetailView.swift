//
//  TaskspaceDetailView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 06/01/23.
//

import SwiftUI

struct TaskspaceDetailView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    @State var taskspace = TaskspaceModel()
    @FocusState var focusField: FocusField?
    @Binding var isUpdatingTaskspace: Bool
    var body: some View {
        NavigationView {
            ZStack {
                Color.yingYang.ignoresSafeArea()
                VStack(spacing: 30) {
                    UpdateTaskspaceTopContentView(taskspace: taskspace, isUpdatingTaskspace: $isUpdatingTaskspace)
                    
                    ScrollView {
                        
                        VStack(spacing: 12) {
                            
                            CreationTaskspaceNameFieldView(taskspace: $taskspace, focusField: $focusField)
                            
                            CreationTaskspacePasswordFieldView(taskspace: $taskspace, focusField: $focusField)
                            
                            Spacer()
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct TaskspaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskspaceDetailView(isUpdatingTaskspace: .constant(false))
    }
}
