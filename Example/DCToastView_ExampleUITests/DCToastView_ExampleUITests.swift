//
//  DCToastView_ExampleUITests.swift
//  DCToastView_ExampleUITests
//
//  Created by Vincent Berihuete on 11/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest

class DCToastView_ExampleUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testToast() {
        
        let app = XCUIApplication()
        app.buttons["Show toast up"].tap()
        
        let toastExists = app.staticTexts["This is a toast"].waitForExistence(timeout: 3)
        
        assert(toastExists, "The toast wasn't created")
    }

}
