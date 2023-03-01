//
//  TaskPriorityFieldView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

struct TaskPriorityFieldView: View {
    @Binding var priority: TaskPriority
    var body: some View {
        HStack {
            Text("Priority")
            ColoredSegmentedPicker(models: TaskPriority.allCases, selectedModel: $priority)
        }
        
    }
}

struct TaskPriorityFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TaskPriorityFieldView(priority: .constant(.none))
    }
}
