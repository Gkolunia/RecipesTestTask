//
//  HomeTabBarController.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/31/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation
import UIKit


/**
 * @brief Delegate of navigation. Currently it is RecipesCoordinator.
 */
protocol HomeControllerDelegateProtocol : class {
    /**
     * @brief Navigate to sign in form.
     */
    func homeControllerDidLogout()
}

class HomeTabBarController : UITabBarController {
    
    weak var logoutManager : LogoutManagerProtocol!
    weak var delegateNavigation: HomeControllerDelegateProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateLogoutButton()
    }
    
    private func configurateLogoutButton() {
        let backItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutOnClick))
        navigationItem.leftBarButtonItem = backItem
        navigationItem.title = "Recipes"
    }
    
    @objc func logoutOnClick() {
        logoutManager?.logout()
        delegateNavigation?.homeControllerDidLogout()
    }
}
