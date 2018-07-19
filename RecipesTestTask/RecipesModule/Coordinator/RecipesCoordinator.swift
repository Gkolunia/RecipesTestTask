//
//  RecipesCoordinator.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/14/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/**
 * @brief The class provides navigation for recipes module.
 */
class RecipesCoordinator : Coordinator, RecipeDetailsControllerDelegateProtocol, RecipesControllerDelegateProtocol {
    
    weak var recipesViewController: RecipesTableViewController?
    
    func start(from viewController: UIViewController, animated: Bool) {
        
        let recipesController = UIStoryboard.recipesTableViewController()
        recipesController.recipesDataManager = DataManager()
        _ = recipesController.view
        recipesController.tableViewConfigurator = RecipesTableConfigurator(with: recipesController.tableView)
        recipesController.delegate = self
        if let tabBarController = viewController as? UITabBarController {
            tabBarController.addChildViewController(recipesController)
        }
        else {
            viewController.show(recipesController, sender: self)
        }
        
        
        recipesViewController = recipesController
        
    }
    
    func showDetails(with recipe: Recipe, from controller: UIViewController) {
        let recipeDetailsController = UIStoryboard.recipeDetailsViewController()
        recipeDetailsController.recipe = recipe
        recipeDetailsController.dataManager = DataManager()
        recipeDetailsController.delegate = self
        controller.show(recipeDetailsController, sender: self)
    }
    
    // MARK: RecipeDetailsControllerDelegateProtocol
    func popViewControllerAndUpdateList(_ controller: UIViewController, with recipeDetails: RecipeDetails) {
        if let recipesViewController = recipesViewController {
            recipesViewController.tableViewConfigurator.updateList(with: recipeDetails)
        }
        controller.navigationController?.popViewController(animated: true)
    }
    
}
