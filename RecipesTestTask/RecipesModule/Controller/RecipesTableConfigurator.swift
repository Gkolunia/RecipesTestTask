//
//  RecipeTableConfigurator.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/14/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/**
 * @brief Protocol of table configurator for recipes list controller
 */
protocol RecipesTableConfiguratorProtocol : UITableViewDelegate, UITableViewDataSource {
    
    /**
     * @brief Call back - is called when something is selected from table view.
     */
    var selectionHandler: ((_ selectedItem: Recipe) -> ())? { get set }
    
    /**
     * @brief Recipes list for table view.
     */
    var recipes : [Recipe] { get set }
    
    init(with TableView: UITableView)
    
    /**
     * @brief Update some particular recipe in the list recipes.
     */
    func updateList(with recipe: RecipeDetails)
}

/**
 * @brief Implementation RecipesTableConfiguratorProtocol.
 */
class RecipesTableConfigurator: NSObject, RecipesTableConfiguratorProtocol {
    
    var selectionHandler: ((_ selectedItem: Recipe) -> ())?
    
    var recipes : [Recipe] = [Recipe]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    weak var tableView: UITableView!
    
    required init(with tableView: UITableView) {
        super.init()
        self.tableView = tableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func updateList(with recipe: RecipeDetails) {
        
        let index = recipes.index { (item) -> Bool in
            return item.itemId == recipe.itemId
        }
        
        if let index = index {
            recipes[index].favorite = recipe.favorite
            recipes[index].ratings = recipe.ratings
            recipes[index].rating = recipe.rating
            recipes[index].ratedByMe = recipe.ratedByMe
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: DataChangeNotification.kFavoriteChanged), object: recipes[index])
        }
        
    }

}

extension RecipesTableConfigurator : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let callback = selectionHandler {
            callback(recipes[indexPath.row])
        }
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
}

extension RecipesTableConfigurator : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeListConstants.kRecipeCellId) as? RecipeCell else {
            fatalError()
        }
        
        cell.setup(with: recipes[indexPath.row])
        
        return cell
    }
    
}
