//
//  SignInCoordinator.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/14/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/**
 * @brief Protocol of parent coordinator.
 */
protocol SignInCoordinatorDelegate : class {
    /**
     * @brief Method is called when SignInCoordinator is finished its navigation.
     */
    func didSignIn()
}

/**
 * @brief The class provides navigation for signIn module.
 */
class SignInCoordinator : Coordinator, SignInDelegateProtocol  {
    
    fileprivate weak var delegate: SignInCoordinatorDelegate?
    
    init(with delegateDefault: SignInCoordinatorDelegate) {
        delegate = delegateDefault
    }
    
    /**
     * @brief Show signIn controller.
     */
    func start(from viewController: UIViewController, animated: Bool) {
        
        let signInController = UIStoryboard.signInController()
        signInController.delegate = self
        signInController.signInManager = UserSessionManager.shared
        viewController.present(signInController, animated: animated, completion: nil)
        
    }
    
    
    // MARK: SignInDelegateProtocol
    
    func signInControllerDidSignIn(_ controller: UIViewController) {
        guard let delegate = delegate else {
            fatalError()
        }
        controller.dismiss(animated: true, completion: nil)
        delegate.didSignIn() // Finish of sign in navigation process
    }
    
    func handle(_ error: Error, from controller: UIViewController) {
        let alert = UIAlertController(title: "Sign In", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
}
