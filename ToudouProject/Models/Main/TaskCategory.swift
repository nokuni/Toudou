//
//  TaskCategory.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import Foundation

struct TaskCategory: Identifiable {
    var id = UUID()
    var name: String = "Neutral"
    var icon: String = "neutral.icon"
}

extension TaskCategory {
    static var icons: [String] {
        ["important.icon", "schedule.icon", "people.icon", "food.icon", "chill.icon", "chore.icon"]
    }
}
