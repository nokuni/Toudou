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
        fetchTaskCategories()
        createFakeJoiningTaskSpace()
        createStartingCategory()
        fetchTaskspaces()
        setUpTaskspaceOffsets()
        fetchTasks()
        setUpTaskOffsets()
        print(taskCategories.map { $0.name })
        print(taskCategories.map { $0.icon })
    }
    
    @Published var selectedTaskspace: TaskspaceEntity?
    
    @Published var tasks = [TaskEntity]()
    @Published var taskspaces = [TaskspaceEntity]()
    @Published var taskCategories = [TaskCategoryEntity]()
    
    @Published var taskOffsets = [CGSize]()
    @Published var taskspaceOffsets = [CGSize]()
    @Published var isOnEditMode: Bool = false
    
    let animation = ChainAnimation()
    
    // MARK: SPACES
    func fetchTaskspaces() {
        let sorting = [NSSortDescriptor(keyPath: \TaskEntity.id, ascending: true)]
        taskspaces = CoreDataManager.shared.fetch("TaskspaceEntity", sorting: sorting)
    }
    func deleteTaskspace(taskspace: TaskspaceEntity) {
        let tasksToDelete = tasks.filter {
            if let idString = $0.id?.uuidString { return taskspace.tasks.contains(idString) }
            return false
        }
        CoreDataManager.shared.delete(objects: tasksToDelete)
        fetchTasks()
        setUpTaskOffsets()
        
        CoreDataManager.shared.delete(object: taskspace)
        fetchTaskspaces()
        setUpTaskspaceOffsets()
    }
    func createTaskspace(taskspace: TaskspaceModel) {
        withAnimation {
            
            let newTaskspace = TaskspaceEntity(context: CoreDataManager.shared.container.viewContext)
            
            newTaskspace.id = taskspace.id
            newTaskspace.name = taskspace.name
            newTaskspace.tasks = taskspace.tasks
            newTaskspace.image = taskspace.image
            newTaskspace.isOwning = true
            newTaskspace.isHidden = false
            newTaskspace.contributors = taskspace.contributors
            newTaskspace.password = taskspace.password
            
            CoreDataManager.shared.saveData()
            fetchTaskspaces()
            setUpTaskspaceOffsets()
        }
    }
    func filteredTaskspaces(sorting: TaskspaceBelonging) -> [TaskspaceEntity] {
        let all = taskspaces.filter { !$0.isHidden }
        let owned = taskspaces.filter { $0.isOwning && !$0.isHidden }
        let joined = taskspaces.filter { !$0.isOwning && !$0.isHidden }
        
        switch sorting {
        case .all:
            return all
        case .owned:
            return owned
        case .joined:
            return joined
        }
    }
    func joinTaskspace(with name: String, and password: String) {
        if let index = taskspaces.firstIndex(where: { taskspace in
            taskspace.name == name && taskspace.password == password
        }) {
            taskspaces[index].isHidden = false
            
            CoreDataManager.shared.saveData()
            fetchTaskspaces()
            setUpTaskspaceOffsets()
        }
    }
    func createFakeJoiningTaskSpace() {
        if taskspaces.isEmpty {
            
            let taskspace = TaskspaceModel(name: "Harry Potter", password: "Magic")
            
            withAnimation {
                
                let newTaskspace = TaskspaceEntity(context: CoreDataManager.shared.container.viewContext)
                
                newTaskspace.id = taskspace.id
                newTaskspace.name = taskspace.name
                newTaskspace.tasks = taskspace.tasks
                newTaskspace.image = taskspace.image
                newTaskspace.isOwning = false
                newTaskspace.contributors = taskspace.contributors
                newTaskspace.password = taskspace.password
                
                CoreDataManager.shared.saveData()
                fetchTaskspaces()
                setUpTaskspaceOffsets()
            }
        }
    }
    func updateTasksInTaskspace(idString: String) {
        selectedTaskspace?.tasks.append(idString)
        CoreDataManager.shared.saveData()
        fetchTaskspaces()
    }
    func updateTaskspace(taskspace: TaskspaceModel) {
        if let index = taskspaces.firstIndex(where: { $0.id == taskspace.id }) {
            taskspaces[index].name = taskspace.name
            taskspaces[index].password = taskspace.password
            
            CoreDataManager.shared.saveData()
            fetchTaskspaces()
            setUpTaskspaceOffsets()
        }
    }
    
    // MARK: - TASKS
    var selectedTasks: [TaskEntity] {
        guard let selectedTaskspace = selectedTaskspace else { return [] }
        
        let taskspaceTasks = tasks.filter { task in
            if let idString = task.id?.uuidString {
                return selectedTaskspace.tasks.contains(idString)
            }
            return false
        }
        
        return taskspaceTasks
    }
    
    func fetchTasks() {
        let sorting = [NSSortDescriptor(keyPath: \TaskEntity.id, ascending: true)]
        tasks = CoreDataManager.shared.fetch("TaskEntity", sorting: sorting)
    }
    func deleteTask(task: TaskEntity) {
        CoreDataManager.shared.delete(object: task)
        fetchTasks()
        setUpTaskOffsets()
    }
    func createTask(task: TaskModel) {
        withAnimation {
            
            let newTask = TaskEntity(context: CoreDataManager.shared.container.viewContext)
            
            newTask.id = task.id
            newTask.title = task.title
            newTask.notes = task.notes
            newTask.date = task.date
            newTask.place = task.place
            newTask.priority = Int16(task.priority.rawValue)
            newTask.reminder = task.reminder.rawValue
            newTask.category = task.category.name
            
            CoreDataManager.shared.saveData()
            fetchTasks()
            setUpTaskOffsets()
            
            updateTasksInTaskspace(idString: task.id.uuidString)
        }
    }
    func updateTask(task: TaskModel) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].title = task.title
            tasks[index].place = task.place
            tasks[index].priority = Int16(task.priority.rawValue)
            tasks[index].category = task.category.name
            tasks[index].notes = task.notes
            
            CoreDataManager.shared.saveData()
            fetchTasks()
            setUpTaskOffsets()
            
            updateTasksInTaskspace(idString: task.id.uuidString)
        }
    }
    
    func filteredTasks(sorting: TaskSorting) -> [TaskEntity] {
        let today = selectedTasks.filter {
            guard let date = $0.date else { return false }
            return date.isToday && !$0.isDone
        }
        let planned = selectedTasks.filter {
            guard let date = $0.date else { return false }
            return !date.isToday && !$0.isDone
        }
        let done = selectedTasks.filter { $0.isDone }
        
        switch sorting {
        case .all:
            return selectedTasks
        case .today:
            return today
        case .planned:
            return planned
        case .done:
            return done
        }
    }
    func sortTaskByPriority(on ascending: Bool) {
        let sorting = [NSSortDescriptor(keyPath: \TaskEntity.priority, ascending: ascending)]
        tasks = CoreDataManager.shared.fetch("TaskEntity", sorting: sorting)
        CoreDataManager.shared.saveData()
        setUpTaskOffsets()
    }
    func validateTask(task: TaskEntity) {
        withAnimation {
            if let index = tasks.firstIndex(of: task) { tasks[index].isDone = true }
            CoreDataManager.shared.saveData()
            fetchTasks()
        }
    }
    
    // MARK: - TASK UI
    func setUpTaskOffsets() {
        taskOffsets = [CGSize](repeating: .zero, count: tasks.count)
    }
    func toggleTaskEditMode() {
        if isOnEditMode {
            isOnEditMode = false
            setUpTaskOffsets()
        } else {
            isOnEditMode = true
            taskOffsets = [CGSize](repeating: CGSize(width: -120, height: 0), count: tasks.count)
        }
    }
    var taskspaceTitle: String {
        if let selectedTaskspace = selectedTaskspace,
           let taskspaceName = selectedTaskspace.name {
            return taskspaceName
        }
        return "Taskspace"
    }
    
    // MARK: - TASKSPACE UI
    func setUpTaskspaceOffsets() {
        taskspaceOffsets = [CGSize](repeating: .zero, count: taskspaces.count)
    }
    func enterTaskspaceEditMode() {
        if isOnEditMode {
            isOnEditMode = false
            setUpTaskspaceOffsets()
        } else {
            isOnEditMode = true
            taskspaceOffsets = [CGSize](repeating: CGSize(width: -120, height: 0), count: taskspaces.count)
        }
    }
    
    // MARK: - TASK CATEGORIES
    func fetchTaskCategories() {
        let sorting = [NSSortDescriptor(keyPath: \TaskEntity.id, ascending: true)]
        taskCategories = CoreDataManager.shared.fetch("TaskCategoryEntity", sorting: sorting)
    }
    func createStartingCategory() {
        if taskCategories.isEmpty {
            let category = TaskCategoryEntity(context: CoreDataManager.shared.container.viewContext)
            category.name = "Neutral"
            category.icon = "neutral.icon"
            CoreDataManager.shared.saveData()
            fetchTaskCategories()
        }
    }
    func createTaskCategory(taskCategory: TaskCategory) {
        let newCategory = TaskCategoryEntity(context: CoreDataManager.shared.container.viewContext)
        newCategory.id = taskCategory.id
        newCategory.name = taskCategory.name
        newCategory.icon = taskCategory.icon
        CoreDataManager.shared.saveData()
        fetchTaskCategories()
    }
}
