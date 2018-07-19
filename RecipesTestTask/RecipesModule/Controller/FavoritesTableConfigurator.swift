//
//  FavoritesTableConfigurator.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/31/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation
import UIKit

struct DataChangeNotification {
    static let kFavoriteChanged = "kFavoriteChanged"
}

class FavoritesTableConfigurator: RecipesTableConfigurator {
    
    required init(with tableView: UITableView) {
        super.init(with: tableView)
        NotificationCenter.default.addObserver(self, selector: #selector(updateWithItem), name: NSNotification.Name(rawValue: DataChangeNotification.kFavoriteChanged), object: nil)
        
    }
    
    @objc func updateWithItem(notification: NSNotification) {
        
        guard let recipe = notification.object as? Recipe else {
            return
        }
        
        guard let index = recipes.index(of: recipe) else {
            if recipe.favorite {
                recipes.append(recipe)
            }
            return
        }
        
        if !recipe.favorite {
            recipes.remove(at: index)
        }
        
        
    }
    
    
}
