//
//  RateView.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/13/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/**
 * @brief RateView - interection with stars for seting rating in detail controller.
 * @see RecipeDetailsViewController
 */
class RateView: UIView {
    @IBOutlet weak var starImageView_1: UIImageView!
    @IBOutlet weak var starImageView_2: UIImageView!
    @IBOutlet weak var starImageView_3: UIImageView!
    @IBOutlet weak var starImageView_4: UIImageView!
    @IBOutlet weak var starImageView_5: UIImageView!
    
    /**
     * @brief Call back on click - for outside handling. Uses in RecipeDetailsViewController
     */
    var onClickedCallBack : ((_ stars: Int) -> ())?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClicked)))
    }
    
    @objc func onClicked(sender: UITapGestureRecognizer) {
        let location = sender.location(in: self)
        var starsCount = 5
        
        // Define on which star we clicked
        if starImageView_1.frame.contains(location) {
           starsCount = 1
        }
        else if starImageView_2.frame.contains(location) {
            starsCount = 2
        }
        else if starImageView_3.frame.contains(location) {
            starsCount = 3
        }
        else if starImageView_4.frame.contains(location) {
            starsCount = 4
        }
        
        setup(starsCount)
        
        if let handler = onClickedCallBack {
            handler(starsCount)
        }
        
    }
    
    /**
     * @brief Setup state of selected stars
     */
    func setup(_ countStars: Int) {
        
        if countStars == 5 {
            starImageView_1.image = UIImage.starImage()
            starImageView_2.image = UIImage.starImage()
            starImageView_3.image = UIImage.starImage()
            starImageView_4.image = UIImage.starImage()
            starImageView_5.image = UIImage.starImage()
        }
        else if countStars == 4 {
            starImageView_1.image = UIImage.starImage()
            starImageView_2.image = UIImage.starImage()
            starImageView_3.image = UIImage.starImage()
            starImageView_4.image = UIImage.starImage()
            starImageView_5.image = UIImage.emptyStarImage()
        }
        else if countStars == 3 {
            starImageView_1.image = UIImage.starImage()
            starImageView_2.image = UIImage.starImage()
            starImageView_3.image = UIImage.starImage()
            starImageView_4.image = UIImage.emptyStarImage()
            starImageView_5.image = UIImage.emptyStarImage()
        }
        else if countStars == 2 {
            starImageView_1.image = UIImage.starImage()
            starImageView_2.image = UIImage.starImage()
            starImageView_3.image = UIImage.emptyStarImage()
            starImageView_4.image = UIImage.emptyStarImage()
            starImageView_5.image = UIImage.emptyStarImage()
        }
        else if countStars == 1 {
            starImageView_1.image = UIImage.starImage()
            starImageView_2.image = UIImage.emptyStarImage()
            starImageView_3.image = UIImage.emptyStarImage()
            starImageView_4.image = UIImage.emptyStarImage()
            starImageView_5.image = UIImage.emptyStarImage()
        }
        
    }
    
}
