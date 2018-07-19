//
//  AppCoordinator.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/12/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/**
 * @brief Protocol defines common interface for all cordinators
 */
protocol Coordinator {
    /**
     * @brief Method which starts navigation in current coordinator
     */
    func start(from viewController: UIViewController, animated: Bool)
    
}

/**
 * @brief The class provides root navigation for child coordinators. Implements SignInCoordinatorDelegate, RecipesCoordinatorDelegate.
 * @see RecipesCoordinatorDelegate
 * @see SignInCoordinatorDelegate
 */
class AppCoordinator : SignInCoordinatorDelegate, HomeCoordinatorDelegate {
    
    let window : UIWindow
    let rootViewController: UINavigationController = UINavigationController()
    
    /**
     * @brief currentCoordinator keeps reference on last coordinator
     */
    private var currentCoordinator: Coordinator!
    
    public init(_ windowDefault: UIWindow) {
        window = windowDefault
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        rootViewController.view.backgroundColor = .white
    }
    
    func start(with userSession: UserSessionManagerProtocol) {
    
        if userSession.isActiveUserSession() {
            showHome()
        }
        else {
            showSignIn()
        }
        
    }
    
    private func showSignIn() {
        currentCoordinator = SignInCoordinator(with: self)
        currentCoordinator.start(from: rootViewController, animated: false)
    }
    
    private func showHome() {
        currentCoordinator = HomeCoordinator(with: self)
        currentCoordinator.start(from: rootViewController, animated: true)
    }
    
    // MARK: SignInCoordinatorDelegate
    
    func didSignIn() {
        showHome()
    }
    
    // MARK: RecipesCoordinatorDelegate
    
    func doLogOut() {
        rootViewController.viewControllers = []
        currentCoordinator = SignInCoordinator(with: self)
        currentCoordinator.start(from: rootViewController, animated: true)
    }

}
