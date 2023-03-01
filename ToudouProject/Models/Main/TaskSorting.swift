//
//  TaskSorting.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 01/03/23.
//

import Foundation

enum TaskSorting: String, CaseIterable {
    case creationDate = "Creation Date"
    case dueDate = "Due Date"
    case priority = "Priority"
    case title = "Title"
}
