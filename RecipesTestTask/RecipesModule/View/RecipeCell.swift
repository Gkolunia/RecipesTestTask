//
//  RecipeCell.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/13/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/**
 * @brief Recipe cell for recipe list controller. Shows Recipe model.
 * @see Recipe
 */
class RecipeCell: UITableViewCell {
    
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var recipeImageView: ImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func setup(with recipe: Recipe) {
        
        favoriteIcon.isHidden = !recipe.favorite
        titleLabel.text = recipe.name
        headLabel.text = recipe.headline
        ratingLabel.text = String(format: "Rating: %.1f", recipe.rating)
        recipeImageView.loadImageFromURL(url: recipe.imageUrl)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recipeImageView.cancelLoading()
        recipeImageView.image = nil
    }
    
}
