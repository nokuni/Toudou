//
//  ToudouProjectUITests.swift
//  ToudouProjectUITests
//
//  Created by Maertens Yann-Christophe on 02/03/23.
//

import XCTest

final class ToudouProjectUITests: XCTestCase {
    
    func tapOnScreen(in app: XCUIApplication, at point: CGPoint) {
        
        let normalized = app.coordinate(withNormalizedOffset: .zero)
        let offset = CGVector(dx: point.x, dy: point.y)
        let coordinate = normalized.withOffset(offset)
        coordinate.tap()
        
        let delayExpectation = XCTestExpectation()
        delayExpectation.isInverted = true
        wait(for: [delayExpectation], timeout: 1)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNewTaskFields() {
        let app = XCUIApplication()
        app.launch()
        
        // The date advanced by 5 minutes (the app requires it)
                let dueDate = Date.now.addingDate(component: .minute, value: 5)
        // The point where to tap on the screen.
        let tapPoint = CGPoint(x: UIScreen.main.bounds.midX,y: UIScreen.main.bounds.midY * 0.2)
        
        // Open New Task sheet
        let newTaskButton = app.navigationBars["To Do"].buttons["New Task"]
        XCTAssertTrue(newTaskButton.exists)
        newTaskButton.tap()
        
        // The fields and elements are in a scrollView
        let elementsQuery = app.scrollViews.otherElements
        
        // Enter a text in the title textfield
        let titleTextField = elementsQuery.textFields["Title"]
        XCTAssertTrue(titleTextField.exists)
        titleTextField.tap()
        titleTextField.typeText("Hello World")
        
        // Change the priority on the picker
        elementsQuery.staticTexts["Low"].tap()
        elementsQuery.staticTexts["Medium"].tap()
        elementsQuery.staticTexts["High"].tap()
        
        // Toggle the due date
        let dueDateSwitch = elementsQuery.switches["Due date"]
        XCTAssertTrue(dueDateSwitch.exists)
        dueDateSwitch.tap()
        
        // The date pickers elements
        let datePickersQuery = elementsQuery.datePickers
        // Select the date picker
        // The accesible identifier for the date part of the picker is formatted in "MMM d, yyyy".
        // example: "Mar 3, 2023"
        let dueDateButton = datePickersQuery.buttons[dueDate.simpleDate]
        XCTAssertTrue(dueDateButton.exists)
        dueDateButton.tap()
        
        // Select the category navigation button
        let categoryButton = elementsQuery.buttons["Category, Work"]
        XCTAssertTrue(categoryButton.exists)
        categoryButton.tap()
        
        // The categories are in a List
        let collectionViewsQuery = app.collectionViews
        
        // Select a category
        let categoryCell = collectionViewsQuery.buttons["Important"]
        XCTAssertTrue(categoryCell.exists)
        categoryCell.tap()
        
        // Tap on the note field
        let noteField = elementsQuery.textViews["Notes"]
        XCTAssertTrue(noteField.exists)
        noteField.tap()
        noteField.typeText("This is a pretty short note.")
        
        // Tap on the create button
        let createTaskButton = app.buttons["Create"]
        XCTAssertTrue(createTaskButton.exists)
        createTaskButton.tap()
                
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
