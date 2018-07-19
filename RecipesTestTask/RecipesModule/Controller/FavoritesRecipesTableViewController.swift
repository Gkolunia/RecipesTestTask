//
//  FavoritesRecipesTableViewController.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/31/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation
import UIKit

class FavoritesRecipesTableViewController : RecipesTableViewController {
    
    override func loadList() {
        recipesDataManager.getFavorites { (result) in
            switch result {
            case .success(let data):
                self.tableViewConfigurator.recipes = data
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
