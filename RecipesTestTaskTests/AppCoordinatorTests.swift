//
//  AppCoordinatorTests.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/14/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import RecipesTestTask

class AppCoordinatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStartWithoutSignedUser() {

        class UserSessionManagerStub : UserSessionManagerProtocol {
            func isActiveUserSession() -> Bool {
                return false
            }
        }
        
        let appCoordinator = AppCoordinator(UIWindow(frame: UIScreen.main.bounds))
        appCoordinator.start(with: UserSessionManagerStub())
        
        guard let _ = appCoordinator.rootViewController.presentedViewController as? SignInViewController else {
            XCTFail("If there aren't any active user then should be presented Sign In")
            return
        }
        
    }
    
    func testStartWithSignedUser() {
        
        class UserSessionManagerStub : UserSessionManagerProtocol {
            func isActiveUserSession() -> Bool {
                return true
            }
        }
        
        let appCoordinator = AppCoordinator(UIWindow(frame: UIScreen.main.bounds))
        appCoordinator.start(with: UserSessionManagerStub())
        
        guard let _ = appCoordinator.rootViewController.viewControllers[0] as? RecipesTableViewController else {
            XCTFail("If user is already signed then should be push Recipes List")
            return
        }
        
    }
    
    func testDidSignIn() {
        
        let appCoordinator = AppCoordinator(UIWindow(frame: UIScreen.main.bounds))
        appCoordinator.start(with: UserSessionManager())
        appCoordinator.didSignIn()
        
        let expection = expectation(description: "Expectation for animation")
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            expection.fulfill()
            guard let _ = appCoordinator.rootViewController.viewControllers[0] as? RecipesTableViewController else {
                XCTFail("After signing, recipes list should be push")
                return
            }
        }
        
        wait(for: [expection], timeout: 0.5)
        
    }
    
    func testLogout() {
        
        let appCoordinator = AppCoordinator(UIWindow(frame: UIScreen.main.bounds))
        appCoordinator.start(with: UserSessionManager())
        appCoordinator.doLogOut()
        
        guard let _ = appCoordinator.rootViewController.presentedViewController as? SignInViewController else {
            XCTFail("After logouting, sign in should be presented")
            return
        }
        
    }
    
}
