//
//  TaskModel.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 28/02/23.
//

import Foundation

struct TaskModel {
    var title: String = ""
    var notes: String = ""
    var hasDueDate: Bool = false
    var dueDate: Date = Date.now.addingDate(component: .minute, value: 5)
    var priority: TaskPriority = .none
    var reminder: TaskAlertReminder = .none
    var category: TaskCategory = .work
    var isDone: Bool = false
    
    func isReminderPossible(on reminder: TaskAlertReminder) -> Bool {
        Date.now > reminder.reminderDate(from: dueDate)
    }
}
