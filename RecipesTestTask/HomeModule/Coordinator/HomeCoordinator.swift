//
//  Coordinator.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/31/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation
import UIKit

/**
 * @brief Protocol ofr parent coordinator which changes its currentCoordinator.
 */
protocol HomeCoordinatorDelegate : class {
    /**
     * @brief Finish navigation of recepies coordinator. And back to sign in coordinator.
     */
    func doLogOut()
}

class HomeCoordinator: Coordinator, HomeControllerDelegateProtocol {
    
    weak var delegate : HomeCoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    
    init(with delegateDefault: HomeCoordinatorDelegate) {
        delegate = delegateDefault
    }
    
    func start(from viewController: UIViewController, animated: Bool) {
        let homeController = UIStoryboard.homeTabBarController()
        homeController.delegateNavigation = self
        homeController.logoutManager = UserSessionManager.shared
        
        childCoordinators.append(RecipesCoordinator())
        childCoordinators.append(FavoritesCoordinator())
        childCoordinators.forEach {
            $0.start(from: homeController, animated: true)
        }
        
        viewController.show(homeController, sender: self)
    }
    
    // MARK: RecipesControllerDelegateProtocol
    func homeControllerDidLogout() {
        
        guard let delegate = delegate else {
            fatalError()
        }
        
        delegate.doLogOut()
        
    }
    
    
}
