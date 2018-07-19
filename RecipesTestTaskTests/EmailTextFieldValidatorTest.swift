//
//  EmailTextFieldValidatorTest.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/14/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import RecipesTestTask

class UITextFieldMock : UITextField {
    
    var isAddedValidator = false
    override var text: String? {
        didSet {
           sendActions(for: .editingChanged)
        }
    }
    
    override func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControlEvents) {
        super.addTarget(target, action: action, for: controlEvents)
        if let _ = target as? EmailTextFieldValidator, controlEvents == .editingChanged  {
            isAddedValidator = true
        }
        
        if let _ = target as? PasswordTextFieldValidator, controlEvents == .editingChanged  {
            isAddedValidator = true
        }
    }
    
}

class EmailTextFieldValidatorTest: XCTestCase {
    
    var textField: UITextFieldMock!
    var validator: EmailTextFieldValidator!
    
    override func setUp() {
        super.setUp()
        textField = UITextFieldMock()
        validator = EmailTextFieldValidator(with: textField)
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
        
        textField.text = "some@mail.com"
        
        XCTAssertTrue(validator.isValid())
        
        wait(for: [handlerCalling], timeout: 0.1)
        
    }
    
    func testInvalidEmail() {
        
        let handlerCalling = expectation(description: "Expectation for calling call back")
        
        validator.handler = { (isValid) -> () in
            XCTAssertFalse(isValid)
            handlerCalling.fulfill()
        }
        
        textField.text = "somemail.com"
        
        XCTAssertFalse(validator.isValid())
        
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


