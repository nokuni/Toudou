//
//  TaskspaceEntity+CoreDataProperties.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 05/01/23.
//
//

import Foundation
import CoreData


extension TaskspaceEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskspaceEntity> {
        return NSFetchRequest<TaskspaceEntity>(entityName: "TaskspaceEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var tasks: [String]
    @NSManaged public var isOwning: Bool
    @NSManaged public var isHidden: Bool
    @NSManaged public var contributors: [String]
    @NSManaged public var password: String?

}

extension TaskspaceEntity : Identifiable {

}
