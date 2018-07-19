//
//  SignInCoordinatorTests.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/14/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import RecipesTestTask

class SignInDidDelegateMock: SignInCoordinatorDelegate {
    
    var signInIsDone = false
    
    func didSignIn() {
        signInIsDone = true
    }
}

class NavigationControllerMock: UINavigationController {
    
    var lastPresentedViewcontroller : UIViewController!
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        lastPresentedViewcontroller = viewControllerToPresent
    }
    
}

class SignInCoordinatorTests: XCTestCase {
    
    var coordinator : SignInCoordinator!
    var rootViewController : NavigationControllerMock!
    var signInCoordinatorDelegate: SignInDidDelegateMock!
    
    override func setUp() {
        super.setUp()
        
        signInCoordinatorDelegate = SignInDidDelegateMock()
        
        rootViewController = NavigationControllerMock()
        
        coordinator = SignInCoordinator(with: signInCoordinatorDelegate)
        coordinator.start(from: rootViewController, animated: false)
    }
    
    override func tearDown() {
        coordinator = nil
        rootViewController = nil
        signInCoordinatorDelegate = nil
        super.tearDown()
    }
    
    func testStartCoordinatorConfiguration() {
        
        guard let signInController = rootViewController.lastPresentedViewcontroller as? SignInViewController else {
            XCTFail("Wrong controller is presented on start signIn coordinator")
            return
        }
        
        XCTAssertTrue(signInController.signInManager === UserSessionManager.shared, "Wrong sign in manager in signIn controller")
        
        XCTAssertTrue(signInController.delegate === coordinator, "Wrong delegate in signIn controller")
        
    
    }
    
    func testDidSignIn() {
        coordinator.signInControllerDidSignIn(UIViewController())
        XCTAssertTrue(signInCoordinatorDelegate.signInIsDone, "DidSignIn method should called in coordinator delegate")
    }
    
    func testHandleError() {
        coordinator.handle(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey:""]), from: rootViewController)
        let presentingAlert = expectation(description: "Alert Presenting")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            guard let _ = self.rootViewController.lastPresentedViewcontroller as? UIAlertController else {
                XCTFail("Wrong controller is presented on handle error")
                return
            }
            presentingAlert.fulfill()
        }
        wait(for: [presentingAlert], timeout: 0.4)
        
    }
    
}
