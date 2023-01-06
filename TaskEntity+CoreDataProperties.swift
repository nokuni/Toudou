//
//  TaskEntity+CoreDataProperties.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 06/01/23.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var category: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var isDone: Bool
    @NSManaged public var reminder: String?
    @NSManaged public var notes: String?
    @NSManaged public var place: String?
    @NSManaged public var priority: Int16
    @NSManaged public var title: String?

}

extension TaskEntity : Identifiable {

}
