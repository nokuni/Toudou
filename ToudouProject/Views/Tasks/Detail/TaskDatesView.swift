//
//  TaskDatesView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 01/03/23.
//

import SwiftUI

struct TaskDatesView: View {
    @ObservedObject var task: TaskEntity
    var body: some View {
        VStack(spacing: 5) {
            if let creationDate = task.creationDate {
                Text("Created on \(creationDate.medium)")
            }
            
            if let dueDate = task.dueDate {
                Text("Falls on \(dueDate.medium)")
            }
        }
    }
}

struct TaskDatesView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDatesView(task: TaskEntity(context: CoreDataManager.shared.container.viewContext))
    }
}
