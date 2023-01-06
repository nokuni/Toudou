//
//  CoreDataManager.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI
import CoreData

class CoreDataManager {
    
    static var shared = CoreDataManager()
    
    var container = PersistenceController.shared.container
    
    func fetch<R: NSFetchRequestResult>(_ entityName: String, sorting: [NSSortDescriptor]?) -> [R] {
        let request = NSFetchRequest<R>(entityName: entityName)
        request.sortDescriptors = sorting
        do {
            return try container.viewContext.fetch(request)
        } catch let error {
            print("This error THERE")
            print("\(error)")
        }
        return []
    }
    func delete(object: NSManagedObject) {
        withAnimation {
            container.viewContext.delete(object)
            saveData()
        }
    }
    
    func delete(objects: [NSManagedObject]) {
        withAnimation {
            objects.forEach { container.viewContext.delete($0) }
            saveData()
        }
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving \(error)")
        }
    }
}
