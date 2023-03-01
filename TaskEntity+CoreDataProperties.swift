//
//  TaskEntity+CoreDataProperties.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 06/01/23.
//
//

import Foundation
import CoreData
import SwiftUI

extension TaskEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }
    
    @NSManaged public var category: TaskCategory
    @NSManaged public var creationDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var isDone: Bool
    @NSManaged public var notes: String
    @NSManaged public var dueDate: Date?
    @NSManaged public var priority: TaskPriority
    @NSManaged public var reminder: TaskAlertReminder
    @NSManaged public var title: String
}

extension TaskEntity : Identifiable {
    
}
