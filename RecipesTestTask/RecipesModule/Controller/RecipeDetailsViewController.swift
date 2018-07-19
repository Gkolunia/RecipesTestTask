//
//  RecipeDetailsViewController.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/12/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/**
 * @brief Delegate of navigation. Currently it is RecipesCoordinator.
 */
protocol RecipeDetailsControllerDelegateProtocol : class {
    
    /**
     * @brief Navigate to one controller back in stack.
     */
    func popViewControllerAndUpdateList(_ controller: UIViewController, with recipeDetails: RecipeDetails)
}

/**
 * @brief Protocol of data manager for getting details.
 */
protocol RecipeDetailsDataMangerProtocol : class {
    
    /**
     * @brief Get recipe details for showing in details controller.
     */
    func getRecipeDetails(by recipe: Recipe, completionHandler: @escaping (GetObjectResult<RecipeDetails>) -> ())
}

class RecipeDetailsViewController: UIViewController {
    
    @IBOutlet weak var addToFavoritesButton: UIButton!
    @IBOutlet weak var detailInformationTextView: UITextView!
    @IBOutlet weak var recipeImage: ImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var rateView: RateView!
    
    var recipe: Recipe!
    var recipeDetails: RecipeDetails!
    var dataManager: RecipeDetailsDataMangerProtocol!
    weak var delegate: RecipeDetailsControllerDelegateProtocol?
    
    private var doneItem : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRecipeDetails()
        configureDoneButton()
        configureRateView()
    }
    
    private func configureRateView() {
        rateView.onClickedCallBack = {[unowned self] (starsCount) -> () in
            
            self.recipeDetails.ratings = self.recipe.ratings+1 // Increase if you rate it
            self.recipeDetails.rating = self.recipe.rating+Float(starsCount)/Float(self.recipeDetails.ratings) // Recalculation of rating, it should be done on the server side. But I did it for fun :)
            self.recipeDetails.ratedByMe = starsCount // Remeber how much stars did you select
            
            self.doneItem.isEnabled = true // Done button is active if we change something in our model.
        }
    }
    
    private func configureDoneButton() {
        doneItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonClicked))
        navigationItem.title = "Recipe Details"
        navigationItem.rightBarButtonItem = doneItem
        doneItem.isEnabled = false // Done button is disabled by default
    }

    private func loadRecipeDetails() {
        dataManager.getRecipeDetails(by: recipe) { (result) in
            
            switch result {
            case .success(let recipe):
                self.setupView(with: recipe)
            case .failure( _):
                return
                
            }
        }
    }
    
    /**
     * @brief Setup all view from recipe model which was loaded.
     */
    private func setupView(with recipe: RecipeDetails) {
        recipeDetails = recipe
        detailInformationTextView.text = recipe.detailInformation
        nameLabel.text = recipe.name
        headlineLabel.text = recipe.headline
        recipeImage.loadImageFromURL(url: recipe.imageUrl)
        rateView.setup(recipe.ratedByMe)
        
        if recipe.ratedByMe > 0 { // If you rated once, you cannot do it one more time.
            rateView.isUserInteractionEnabled = false
            rateView.alpha = 0.5
        }
        
        if recipe.favorite {
            addToFavoritesButton.setTitle("Remove From Favorites", for: .normal)
        }
        
    }
    
    // MARK: Actions
    
    @IBAction func addFavoriteClicked(_ sender: UIButton) {
        recipeDetails.favorite = !recipeDetails.favorite
        if recipeDetails.favorite { // You can add to favorite and remove it as much as you wish.
            addToFavoritesButton.setTitle("Remove From Favorites", for: .normal)
        }
        else {
            addToFavoritesButton.setTitle("Add To Favorites", for: .normal)
        }
        
        if recipe.favorite != recipeDetails.favorite ||
            recipe.ratings != recipeDetails.ratings { // Done button is active if we change something in our model.
            doneItem.isEnabled = true
        }
        else {
            doneItem.isEnabled = false
        }
    }
    
    /**
     * @brief Update recipe if you change status of favorite or rate the recipe.
     */
    @objc func doneButtonClicked() {
        if let delegate = delegate {
            delegate.popViewControllerAndUpdateList(self, with: recipeDetails)
        }
    }

}
