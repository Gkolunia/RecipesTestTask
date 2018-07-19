//
//  StoryBoard.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/12/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

struct StoryBoard {
    static let kSignInViewControllerId = "SignInViewControllerID"
    static let kRecipesTableViewControllerId = "RecipesTableViewControllerID"
    static let kRecipeDetailsViewControllerId = "RecipeDetailsViewControllerID"
    static let kHomeViewControllerId = "HomeViewControllerID"
    static let kFavoriteViewControllerId = "FavoriteViewControllerID"
}

/**
 * @brief Default controllers of application in main story board. Just for convenience usage.
 */
extension UIStoryboard {
    
    class func main() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    class func signInController() -> SignInViewController {
        return main().instantiateViewController(withIdentifier: StoryBoard.kSignInViewControllerId) as! SignInViewController
    }
    
    class func recipesTableViewController() -> RecipesTableViewController {
        return main().instantiateViewController(withIdentifier: StoryBoard.kRecipesTableViewControllerId) as! RecipesTableViewController
    }
    
    class func recipeDetailsViewController() -> RecipeDetailsViewController {
        return main().instantiateViewController(withIdentifier: StoryBoard.kRecipeDetailsViewControllerId) as! RecipeDetailsViewController
    }
    
    class func favoritesController() -> FavoritesRecipesTableViewController {
        return main().instantiateViewController(withIdentifier: StoryBoard.kFavoriteViewControllerId) as! FavoritesRecipesTableViewController
    }
    
    class func homeTabBarController() -> HomeTabBarController {
        return main().instantiateViewController(withIdentifier: StoryBoard.kHomeViewControllerId) as! HomeTabBarController
    }
    
}
