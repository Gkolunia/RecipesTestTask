//
//  PasswordTextFieldValidatorTests.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/14/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import RecipesTestTask

class PasswordTextFieldValidatorTests: XCTestCase {
    
    var textField: UITextFieldMock!
    var validator: PasswordTextFieldValidator!
    
    override func setUp() {
        super.setUp()
        textField = UITextFieldMock()
        validator = PasswordTextFieldValidator(with: textField)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        textField = nil
        validator = nil
        super.tearDown()
    }
    
    func testIsValidatorAddedAsTarget() {
        XCTAssertTrue(textField.isAddedValidator)
    }
    
    func testValidEmail() {
        
        let handlerCalling = expectation(description: "Expectation for calling call back")
        
        validator.handler = { (isValid) -> () in
            XCTAssertTrue(isValid)
            
            handlerCalling.fulfill()
        }
        
        textField.text = "password123"
        
        XCTAssertTrue(validator.isValid())
        
        wait(for: [handlerCalling], timeout: 0.1)
        
    }
    
    func testInvalidEmail() {
        
        let handlerCalling = expectation(description: "Expectation for calling call back")
        
        validator.handler = { (isValid) -> () in
            XCTAssertFalse(isValid)
            handlerCalling.fulfill()
        }
        
        XCTAssertFalse(validator.isValid())
        
        textField.text = "password"
        
        wait(for: [handlerCalling], timeout: 0.1)
        
    }
    
    func testEmptyField() {

        let handlerCalling = expectation(description: "Expectation for calling call back")
        
        validator.handler = { (isValid) -> () in
            XCTAssertFalse(isValid)
            handlerCalling.fulfill()
        }
        
        
        textField.text = nil

        XCTAssertFalse(validator.isValid())
        
        wait(for: [handlerCalling], timeout: 0.1)
        
    }
    

    
}
