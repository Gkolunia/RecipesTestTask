//
//  FavoritesCoordinator.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/31/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation
import UIKit

class FavoritesCoordinator : RecipesCoordinator {
    
    override func start(from viewController: UIViewController, animated: Bool) {
        
        let favoritesController = UIStoryboard.favoritesController()
        favoritesController.recipesDataManager = DataManager()
        _ = favoritesController.view
        favoritesController.tableViewConfigurator = FavoritesTableConfigurator(with: favoritesController.tableView)
        favoritesController.delegate = self
        if let tabBarController = viewController as? UITabBarController {
            tabBarController.addChildViewController(favoritesController)
        }
        else {
            viewController.show(favoritesController, sender: self)
        }
        recipesViewController?.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        recipesViewController = favoritesController
        
    }
    
    
}
