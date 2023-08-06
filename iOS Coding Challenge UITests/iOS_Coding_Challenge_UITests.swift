//
//  iOS_Coding_Challenge_UITests.swift
//  iOS Coding Challenge UITests
//
//  Created by Nghia Dinh on 06/08/2023.
//

import XCTest
import Foundation

final class iOS_Coding_Challenge_UITests: XCTestCase {

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
                
        

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testHello() throws {
                        
    }
    
    
    
    func testAllNoteView() throws {
        let app = XCUIApplication()
        app.launch()
        
        let allNotesTab = app.tabBars.buttons["All Notes"]
        allNotesTab.tap()
        
        let loadingIndicator = app.progressIndicators["Loading all notes..."]
        let exists = NSPredicate(format: "exists == false")
        expectation(for: exists, evaluatedWith: loadingIndicator, handler: nil)
        XCTAssertTrue(app.collectionViews["noteList"].exists)
    }
    
    func testMyNote() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars["Tab Bar"].buttons["My Notes"].tap()
        app.buttons["Login"].tap()
        app.textFields["Enter text here"].tap()
        app.textFields["Enter text here"].typeText("nghia.dinh.55")
        app.buttons["Submit"].tap()
        let loadingIndicator = app.progressIndicators["Loading all notes..."]
        let exists = NSPredicate(format: "exists == false")
        expectation(for: exists, evaluatedWith: loadingIndicator, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(app.collectionViews["myNotes"].exists)
    }
    
    func testCreateNote() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars["Tab Bar"].buttons["My Notes"].tap()
        app.buttons["Login"].tap()
        app.textFields["Enter text here"].tap()
        app.textFields["Enter text here"].typeText("nghia.dinh.55")
        app.buttons["Submit"].tap()
        app.navigationBars["nghia.dinh.55"].buttons["Add"].tap()
        app.textViews["createNoteTextEditor"].tap()
        app.textViews["createNoteTextEditor"].typeText("ui test create note")
        app.buttons["Create"].tap()
        let alert = app.alerts["Alert"]
        XCTAssertTrue(alert.exists)
        
        // Verify the alert message
        let alertMessage = alert.staticTexts["Create note successfuly"]
        XCTAssertTrue(alertMessage.exists)
        XCTAssertEqual(alertMessage.label, "Create note successfuly")
                
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
