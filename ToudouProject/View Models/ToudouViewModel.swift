//
//  ToudouViewModel.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI
import CoreData

class ToudouViewModel: ObservableObject {
    
    init() {
        readTasks()
    }
    
    @Published var tasks = [TaskEntity]()
    @Published var sortOrder: SortOrder = .ascending
    @Published var selectedSort: TaskSorting = .creationDate
    @Published var selectedTask: TaskEntity?
    @Published var isTaskAdding: Bool = false
    @Published var isTaskEditing: Bool = false
    @Published var isEditing: Bool = false
    
    // MARK: - TASKS
    func createTask(taskModel: TaskModel) {
        withAnimation {
            
            let newTask = TaskEntity(context: CoreDataManager.shared.container.viewContext)
            
            newTask.id = UUID()
            newTask.title = taskModel.title
            newTask.notes = taskModel.notes
            newTask.creationDate = Date.now
            newTask.dueDate = taskModel.hasDueDate ? taskModel.dueDate : nil
            newTask.priority = taskModel.priority
            newTask.reminder = taskModel.reminder
            newTask.category = taskModel.category
            
            CoreDataManager.shared.saveData()
            readTasks()
            
            NotificationManager.shared.scheduleReminderNotification(of: newTask)
        }
    }
    
    func readTasks() {
        switch selectedSort {
        case .creationDate:
            fetch(keyPath: \TaskEntity.creationDate, order: sortOrder.rawValue)
        case .dueDate:
            fetch(keyPath: \TaskEntity.dueDate, order: sortOrder.rawValue)
        case .priority:
            fetch(keyPath: \TaskEntity.priority, order: !sortOrder.rawValue)
        case .title:
            fetch(keyPath: \TaskEntity.title, order: !sortOrder.rawValue)
        }
    }
    
    func updateTask(taskModel: TaskModel) {
        guard let selectedTask = selectedTask else { return }
        if let index = tasks.firstIndex(where: { $0.id == selectedTask.id }) {
            tasks[index].title = taskModel.title
            tasks[index].dueDate = taskModel.dueDate
            tasks[index].reminder = taskModel.reminder
            tasks[index].priority = taskModel.priority
            tasks[index].category = taskModel.category
            tasks[index].notes = taskModel.notes
            
            CoreDataManager.shared.saveData()
            readTasks()
            
            if let id = tasks[index].id {
                NotificationManager.shared.removeNotifications(from: id.uuidString)
                NotificationManager.shared.scheduleReminderNotification(of: tasks[index])
            }
            
            self.selectedTask = tasks[index]
        }
    }
    
    func deleteTask(_ task: TaskEntity) {
        CoreDataManager.shared.delete(object: task)
        CoreDataManager.shared.saveData()
        readTasks()
    }
    
    // MARK: - Sort and filters
    
    func filteredTasks(_ filter: TaskFiltering) -> [TaskEntity] {
        let today = tasks.filter {
            guard let dueDate = $0.dueDate else { return false }
            return dueDate.isToday && !$0.isDone
        }
        let planned = tasks.filter {
            guard let dueDate = $0.dueDate else { return false }
            return !dueDate.isToday && !$0.isDone
        }
        let done = tasks.filter { $0.isDone }
        
        switch filter {
        case .all:
            return tasks
        case .today:
            return today
        case .planned:
            return planned
        case .done:
            return done
        }
    }
    
    func currentSort<Value>(keyPath: KeyPath<TaskEntity, Value>, order: Bool) -> [NSSortDescriptor] {
        let sorting = [NSSortDescriptor(keyPath: keyPath, ascending: order)]
        return sorting
    }
    
    func fetch<Value>(keyPath: KeyPath<TaskEntity, Value>, order: Bool) {
        let sorting = currentSort(keyPath: keyPath, order: order)
        tasks = CoreDataManager.shared.fetch("TaskEntity", sorting: sorting)
        CoreDataManager.shared.saveData()
    }
    
    func switchSortOrder() {
        sortOrder.toggle()
        readTasks()
    }
    
    func toggleTaskValidation(task: TaskEntity) {
        withAnimation {
            if let index = tasks.firstIndex(of: task) { tasks[index].isDone.toggle() }
            CoreDataManager.shared.saveData()
            readTasks()
        }
    }
}
