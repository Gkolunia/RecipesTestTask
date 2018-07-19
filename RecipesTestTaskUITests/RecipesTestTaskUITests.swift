//
//  RecipesTestTaskUITests.swift
//  RecipesTestTaskUITests
//
//  Created by Hrybenuik Mykola on 8/9/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import XCTest

class RecipesTestTaskUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testSignInScreen() {
        let app = XCUIApplication()
        app.launchArguments = [LaunchConstants.testModeReset]
        app.launch()
        
        XCUIDevice.shared().orientation = .portrait
        
        let emailTextField = app.textFields["email"]
        emailTextField.tap()
        emailTextField.typeText("some@email.com")
        
        let passwordSecureTextField = app.secureTextFields["password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("pass1")
        app.buttons["Sign In"].tap()
        
    }
    
    func testListDidSelect() {
        
        let app = XCUIApplication()
        app.launchArguments = [LaunchConstants.testModeSigned]
        app.launch()
        
        XCUIDevice.shared().orientation = .portrait
    
        app.tables.staticTexts["with Sweet Potato Wedges and Minted Snap Peas"].tap()
        app.otherElements.containing(.navigationBar, identifier:"Recipe Details").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.tap()
        app.buttons["Add To Favorites"].tap()
        app.navigationBars["Recipe Details"].buttons["Done"].tap()
        
        
    }
    
}
