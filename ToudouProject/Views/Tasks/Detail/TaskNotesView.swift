//
//  TaskNotesView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 01/03/23.
//

import SwiftUI

struct TaskNotesView: View {
    @ObservedObject var task: TaskEntity
    var body: some View {
        Text(task.notes.isEmpty ? "Empty notes" : task.notes)
            .font(.callout)
            .foregroundColor(task.notes.isEmpty ? .secondary : .primary)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct TaskNotesView_Previews: PreviewProvider {
    static var previews: some View {
        TaskNotesView(task: TaskEntity(context: CoreDataManager.shared.container.viewContext))
    }
}
