//
//  ToudouProjectTests.swift
//  ToudouProjectTests
//
//  Created by Maertens Yann-Christophe on 01/03/23.
//

import XCTest
import Utility_Toolbox
@testable import ToudouProject

final class ToudouProjectTests: XCTestCase {
    
    var viewModel: ToudouViewModel!
    var task = TaskModel()
    
    override func setUp() {
        viewModel = ToudouViewModel()
        viewModel.saveManager.deleteAll(objects: viewModel.tasks)
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    // Test maximum number of characters in title
    func testTaskTitleMaximumCount() throws {
        // Given
        let title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
        let maximumCharacterCount = 30
        // When
        task.title = title
        viewModel.createTask(taskModel: task)
        // Then
        let expectedResult = viewModel.tasks[0].title.count <= maximumCharacterCount
        XCTAssertFalse(expectedResult)
    }
    // Test title is not empty
    func testTaskTitleIsNotEmpty() throws {
        // Given
        let title = ""
        // When
        task.title = title
        viewModel.createTask(taskModel: task)
        // Then
        let expectedResult = !viewModel.tasks[0].title.isEmpty
        XCTAssertFalse(expectedResult)
    }
    // Test model title is entity title
    func testTaskTitle() {
        // Given
        let title = "Hello World"
        // When
        task.title = title
        viewModel.createTask(taskModel: task)
        // Then
        XCTAssertEqual(viewModel.tasks[0].title, title)
    }
    
    // Test model priority is entity priority
    func testTaskPriorityField() throws {
        // Given
        let priority: TaskPriority = .medium
        // When
        task.priority = .medium
        viewModel.createTask(taskModel: task)
        // Then
        XCTAssertEqual(viewModel.tasks[0].priority, priority)
    }
    
    // Test task has no due date
    func testTaskHasNoDueDate() throws {
        // Given
        let date = Date.now
        // When
        task.dueDate = date
        viewModel.createTask(taskModel: task)
        // Then
        XCTAssertNil(viewModel.tasks[0].dueDate)
    }
    // Test model due date is entity due date
    func testTaskDueDateField() throws {
        // Given
        let date = Date.now
        // When
        task.hasDueDate = true
        task.dueDate = date
        viewModel.createTask(taskModel: task)
        // Then
        XCTAssertEqual(viewModel.tasks[0].dueDate, date)
    }
    
    // Test if reminder date is applicable on a date.
    func testReminderDate() {
        // Given
        let reminder: TaskAlertReminder = .oneWeekBefore
        // When
        let addedDate = Date.now.addingDate(component: .month, value: 1)
        task.dueDate = addedDate
        // Then
        let expectedResult = task.isReminderPossible(on: reminder)
        XCTAssertFalse(expectedResult)
    }
    // Test model reminder is entity reminder
    func testTaskReminderField() throws {
        // Given
        let reminder: TaskAlertReminder = .fiveMinutesBefore
        // When
        task.reminder = reminder
        viewModel.createTask(taskModel: task)
        // Then
        XCTAssertEqual(viewModel.tasks[0].reminder, reminder)
    }
    
    // Test model category is entity category
    func testTaskCategoryField() throws {
        // Given
        let category: TaskCategory = .important
        var taskModel = TaskModel()
        // When
        taskModel.category = category
        viewModel.createTask(taskModel: taskModel)
        // Then
        XCTAssertEqual(viewModel.tasks[0].category, category)
    }
    
    // Test maximum number of characters in notes
    func testTaskNotesMaximumCount() throws {
        // Given
        let notes = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        let maximumCharacterCount = 300
        var taskModel = TaskModel()
        // When
        taskModel.notes = notes
        viewModel.createTask(taskModel: taskModel)
        // Then
        XCTAssertGreaterThan(viewModel.tasks[0].notes.count, maximumCharacterCount)
    }
    // Test model notes is entity notes
    func testTaskNotesField() {
        // Given
        let notes = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        var taskModel = TaskModel()
        // When
        taskModel.notes = notes
        viewModel.createTask(taskModel: taskModel)
        // Then
        XCTAssertEqual(viewModel.tasks[0].notes, notes)
    }
    
    // Test if a task is correctly added and read
    func testTaskCreation() throws {
        // Given
        let taskModel = TaskModel()
        // When
        viewModel.createTask(taskModel: taskModel)
        // Then
        XCTAssertNotEqual(viewModel.tasks.count, 0)
    }
    
    // Test if a task is correctly updated
    func testTaskEdition() throws {
        // Given
        let oldTitle = "Important task"
        let newTitle = "Trivial task"
        var taskModel = TaskModel()
        // When
        taskModel.title = oldTitle
        viewModel.createTask(taskModel: taskModel)
        taskModel.title = newTitle
        viewModel.tasks[0].title = taskModel.title
        viewModel.save()
        viewModel.readTasks()
        // Then
        XCTAssertNotEqual(viewModel.tasks[0].title, oldTitle)
    }
    
    // Test if a task is correctly deleted
    func testTaskDeletion() throws {
        // Given
        let taskModel = TaskModel()
        // When
        viewModel.createTask(taskModel: taskModel)
        viewModel.saveManager.delete(viewModel.tasks[0])
        viewModel.readTasks()
        // Then
        XCTAssertEqual(viewModel.tasks.count, 0)
    }
    
    // Test if a task is correctly deleted
    func testTaskValidation() throws {
        // Given
        let taskModel = TaskModel()
        // When
        viewModel.createTask(taskModel: taskModel)
        viewModel.toggleTaskValidation(task: viewModel.tasks[0])
        // Then
        XCTAssertTrue(viewModel.tasks[0].isDone)
    }
    
    // Test the filter applied on all tasks
    func testAllTasks() throws {
        // Given
        // When
        task.hasDueDate = true
        viewModel.createTask(taskModel: task)
        
        task.hasDueDate = true
        task.dueDate = Date.now.addingDate(component: .day, value: 5)
        viewModel.createTask(taskModel: task)
        
        task = TaskModel()
        
        task.isDone = true
        viewModel.createTask(taskModel: task)
        // Then
        XCTAssertEqual(viewModel.tasks, viewModel.filteredTasks())
    }
    
    // Test the filter applied on today tasks
    func testTodayTasks() throws {
        // Given
        // When
        task.hasDueDate = true
        viewModel.createTask(taskModel: task)
        // Then
        XCTAssertEqual(viewModel.tasks, viewModel.filteredTasks())
    }
    
    // Test the filter applied on planned tasks
    func testPlannedTasks() throws {
        // Given
        // When
        task.hasDueDate = true
        task.dueDate = Date.now.addingDate(component: .day, value: 5)
        viewModel.createTask(taskModel: task)
        // Then
        XCTAssertEqual(viewModel.tasks, viewModel.filteredTasks())
    }
    
    // Test the filter applied on planned tasks
    func testDoneTasks() throws {
        // Given
        // When
        task.isDone = true
        viewModel.createTask(taskModel: task)
        // Then
        XCTAssertEqual(viewModel.tasks, viewModel.filteredTasks())
    }
    
    // Test date ascending sorting
    func testDateAscendingSorting() throws {
        // Given
        let calendar = Calendar.current
        
        var firstComponent = DateComponents()
        firstComponent.day = 10
        firstComponent.month = 02
        firstComponent.year = 1993
        
        var secondComponent = DateComponents()
        secondComponent.day = 9
        secondComponent.month = 11
        secondComponent.year = 2001
        
        var thirdComponent = DateComponents()
        thirdComponent.day = 28
        thirdComponent.month = 8
        thirdComponent.year = 1965
        
        let dates = [calendar.date(from: firstComponent),
                     calendar.date(from: secondComponent),
                     calendar.date(from: thirdComponent)]
        // When
        for date in dates {
            let taskEntity = TaskEntity(context: viewModel.saveManager.container.viewContext)
            taskEntity.creationDate = date
            viewModel.save()
        }
        viewModel.sortOrder = .ascending
        viewModel.selectedSort = .creationDate
        viewModel.readTasks()
        let taskDates = viewModel.tasks.compactMap { $0.creationDate }
        // Then
        let expectedResult = [calendar.date(from: secondComponent),
                              calendar.date(from: firstComponent),
                              calendar.date(from: thirdComponent)]
        XCTAssertEqual(taskDates, expectedResult)
    }
    
    // Test date descending sorting
    func testDateDescendingSorting() throws {
        // Given
        let calendar = Calendar.current
        
        var firstComponent = DateComponents()
        firstComponent.day = 10
        firstComponent.month = 02
        firstComponent.year = 1993
        
        var secondComponent = DateComponents()
        secondComponent.day = 9
        secondComponent.month = 11
        secondComponent.year = 2001
        
        var thirdComponent = DateComponents()
        thirdComponent.day = 28
        thirdComponent.month = 8
        thirdComponent.year = 1965
        
        let dates = [calendar.date(from: firstComponent),
                     calendar.date(from: secondComponent),
                     calendar.date(from: thirdComponent)]
        // When
        for date in dates {
            let taskEntity = TaskEntity(context: viewModel.saveManager.container.viewContext)
            taskEntity.creationDate = date
            viewModel.save()
        }
        viewModel.sortOrder = .descending
        viewModel.selectedSort = .creationDate
        viewModel.readTasks()
        // Then
        let taskDates = viewModel.tasks.compactMap { $0.creationDate }
        let expectedResult = [calendar.date(from: thirdComponent),
                              calendar.date(from: firstComponent),
                              calendar.date(from: secondComponent)]
        XCTAssertEqual(taskDates, expectedResult)
    }
    
    // Test priority ascending sorting
    func testPriorityAscendingSorting() throws {
        // Given
        let priorities: [TaskPriority] = [.high, .high, .medium, .low, .none]
        // When
        for priority in priorities {
            var taskModel = TaskModel()
            taskModel.priority = priority
            viewModel.createTask(taskModel: taskModel)
        }
        viewModel.sortOrder = .ascending
        viewModel.selectedSort = .priority
        viewModel.readTasks()
        // Then
        let taskPriorities = viewModel.tasks.compactMap { $0.priority }
        let expectedResult: [TaskPriority] = [.none, .low, .medium, .high, .high]
        XCTAssertEqual(taskPriorities, expectedResult)
    }
    
    // Test priority descending sorting
    func testPriorityDescendingSorting() throws {
        // Given
        let priorities: [TaskPriority] = [.medium, .low, .high, .none, .high]
        // When
        for priority in priorities {
            var taskModel = TaskModel()
            taskModel.priority = priority
            viewModel.createTask(taskModel: taskModel)
        }
        viewModel.sortOrder = .descending
        viewModel.selectedSort = .priority
        viewModel.readTasks()
        // Then
        let taskPriorities = viewModel.tasks.compactMap { $0.priority }
        let expectedResult: [TaskPriority] = [.high, .high, .medium, .low, .none]
        XCTAssertEqual(taskPriorities, expectedResult)
    }
    
    // Test title ascending sorting
    func testTitleAscendingSorting() throws {
        // Given
        let titles: [String] = ["Extra", "Large", "Coke", "Please"]
        // When
        for title in titles {
            var taskModel = TaskModel()
            taskModel.title = title
            viewModel.createTask(taskModel: taskModel)
        }
        viewModel.sortOrder = .ascending
        viewModel.selectedSort = .title
        viewModel.readTasks()
        // Then
        let taskPriorities = viewModel.tasks.compactMap { $0.title }
        let expectedResult: [String] = ["Coke", "Extra", "Large", "Please"]
        XCTAssertEqual(taskPriorities, expectedResult)
    }
    
    // Test title descending sorting
    func testTitleDescendingSorting() throws {
        // Given
        let titles: [String] = ["Extra", "Large", "Coke", "Please"]
        // When
        for title in titles {
            var taskModel = TaskModel()
            taskModel.title = title
            viewModel.createTask(taskModel: taskModel)
        }
        viewModel.sortOrder = .descending
        viewModel.selectedSort = .title
        viewModel.readTasks()
        // Then
        let taskPriorities = viewModel.tasks.compactMap { $0.title }
        let expectedResult: [String] = ["Please", "Large", "Extra", "Coke"]
        XCTAssertEqual(taskPriorities, expectedResult)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

/*
 Given
 
 When
 
 let expectation = XCTestExpectation(description: "testName")
 let result = XCTWaiter.wait(for: [expectation], timeout: 0.5)
 
 Then
 if result == XCTWaiter.Result.timedOut {
 // Write Test
 }
 */
