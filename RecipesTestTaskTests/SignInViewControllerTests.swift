//
//  SignInViewControllerTests.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/14/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import RecipesTestTask

class SignInManagerMock : SignInManagerProtocol {
    
    let expectedEmail = "some@email.com"
    let expectedPassword = "password123"
    
    func signIn(with signInCredetials: UserCredentials, completionHandler: (SingInResult) -> ()) {
        
        if signInCredetials.email == expectedEmail &&
            signInCredetials.password == expectedPassword{
            completionHandler(.success)
        }
        else {
            completionHandler(.failure(NSError(domain: "", code: 1, userInfo: nil)))
        }
        
    }
    
}

class SignInCoordinatorMock: SignInDelegateProtocol {
    
    var didSignIn = false
    var showError = false
    
    func signInControllerDidSignIn(_ controller: UIViewController) {
        didSignIn = true
    }
    
    func handle(_ error: Error, from controller: UIViewController) {
        showError = true
    }
}

class SignInViewControllerTests: XCTestCase {
    
    var signInController : SignInViewController!
    
    override func setUp() {
        super.setUp()
        signInController = UIStoryboard.signInController()
        _ = signInController.view
        signInController.emailTextField = UITextFieldMock()
        signInController.passwordTextField = UITextFieldMock()
        signInController.viewDidLoad()
    }
    
    override func tearDown() {
        signInController = nil
        super.tearDown()
    }
    
    func testInvalidEmailValidPassword() {
        
        signInController.emailTextField.text = "someemail.com"
        signInController.passwordTextField.text = "password12"
        
        XCTAssertFalse(signInController.signInButton.isEnabled)
        
    }
    
    func testValidEmailValidPassword() {
        
        signInController.emailTextField.text = "some@email.com"
        signInController.passwordTextField.text = "password12"
        
        XCTAssertTrue(signInController.signInButton.isEnabled)
        
    }
    
    func testValidEmailInvalidPassword() {
        
        signInController.emailTextField.text = "some@email.com"
        signInController.passwordTextField.text = "password"
        
        XCTAssertFalse(signInController.signInButton.isEnabled)
        
    }
    
    func testSignInOnClickSucces() {
        signInController.emailTextField.text = "some@email.com"
        signInController.passwordTextField.text = "password123"
        signInController.signInManager = SignInManagerMock()
        let signInCoordinatorMock = SignInCoordinatorMock()
        signInController.delegate = signInCoordinatorMock
        signInController.signInOnClick(signInController.signInButton)
        
        XCTAssertTrue(signInCoordinatorMock.didSignIn)
        XCTAssertFalse(signInCoordinatorMock.showError)
    }
    
    func testSignInOnClickFailure() {
        signInController.emailTextField.text = "wrong@email.com"
        signInController.passwordTextField.text = "password123"
        signInController.signInManager = SignInManagerMock()
        let signInCoordinatorMock = SignInCoordinatorMock()
        signInController.delegate = signInCoordinatorMock
        signInController.signInOnClick(signInController.signInButton)
        
        XCTAssertFalse(signInCoordinatorMock.didSignIn)
        XCTAssertTrue(signInCoordinatorMock.showError)
    }
    
}

