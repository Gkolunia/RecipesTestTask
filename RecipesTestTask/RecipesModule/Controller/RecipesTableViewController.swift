//
//  RecipesTableViewController.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/12/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/**
 * @brief CellId of RecipeCell from main story board.
 * @see RecipeCell
 */
struct RecipeListConstants {
    static let kRecipeCellId = "RecipeCellId"
}

/**
 * @brief Delegate of navigation. Currently it is RecipesCoordinator.
 */
protocol RecipesControllerDelegateProtocol : class {
    /**
     * @brief Navigate to details controller.
     */
    func showDetails(with recipe: Recipe, from controller: UIViewController)
}

/**
 * @brief Logout manager for making sign out.
 */
protocol LogoutManagerProtocol : class {
    func logout()
}

/**
 * @brief Protocol of data manager for getting recipes list.
 */
protocol RecipesDataMangerProtocol : class {
    func getRecipes(completionHandler: @escaping (GetListResult<Recipe>) -> ())
    func getFavorites(completionHandler: @escaping (GetListResult<Recipe>) -> ())
}

class RecipesTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    weak var delegate : RecipesControllerDelegateProtocol?

    var recipesDataManager : RecipesDataMangerProtocol!
    var tableViewConfigurator: RecipesTableConfiguratorProtocol! {
        didSet {
            self.tableViewConfigurator.selectionHandler = {[unowned self] (item) -> () in
                self.delegate?.showDetails(with: item, from: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadList()
    }
    
    func loadList() {
        recipesDataManager.getRecipes { (result) in
            switch result {
            case .success(let data):
                self.tableViewConfigurator.recipes = data
            case .failure(let error):
                print(error)
            }
        }
    }

}
