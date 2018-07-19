//
//  UIImage+AppImages.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/13/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

struct ImageConstants {
    static let starImage = "star"
    static let emptyStarImage = "emptyStar"
    static let favoriteImage = "favorite"
}

/**
 * @brief Default images of application. Just for convenience usage.
 */
extension UIImage {
    
    static func starImage() -> UIImage {
        return UIImage(named: ImageConstants.starImage)!
    }
    
    static func emptyStarImage() -> UIImage {
        return UIImage(named: ImageConstants.emptyStarImage)!
    }
    
    static func favoriteImage() -> UIImage {
        return UIImage(named: ImageConstants.favoriteImage)!
    }
    
    
}
