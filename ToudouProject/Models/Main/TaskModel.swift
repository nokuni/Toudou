//
//  TaskModel.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

struct TaskModel: Identifiable {
    var id = UUID()
    var title: String = ""
    var notes: String = ""
    var date: Date = Date()
    var place: String = ""
    var priority: Priority = .none
    var reminder: TaskAlertReminder = .none
    var category = TaskCategory()
    
    enum Priority: Int, CaseIterable, ColorPickerDelegate {
        case none = 1
        case low = 2
        case medium = 3
        case high = 4
        var name: String {
            switch self {
            case .none: return "none"
            case .low: return "low"
            case .medium: return "medium"
            case .high: return "high"
            }
        }
        var color: Color {
            switch self {
            case .none: return .greenApp
            case .low: return .yellowApp
            case .medium: return .orangeApp
            case .high: return .redApp
            }
        }
    }
    
    static func priorityColor(_ priority: Int) -> Color {
        if let priority = Priority.allCases.first(where: { $0.rawValue == priority }) {
            return priority.color
        }
        return .yingYang
    }
    
    static func categoryIcon(from categories: [TaskCategoryEntity], categoryName: String) -> String {
        if let category = categories.first(where: { $0.name == categoryName }),
           let icon = category.icon {
            return icon
        }
        return "questionMark"
    }
}
