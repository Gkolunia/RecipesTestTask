//
//  RecipeDetails.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/13/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation
import Gloss

/**
 * @brief Recipe model for detail controller.
 */
struct RecipeDetails : Glossy {
    
    let itemId: String
    let name: String
    let imageUrl: URL
    var rating: Float
    var ratings: Int
    var favorite: Bool
    let headline: String
    let detailInformation: String
    var ratedByMe: Int = 0
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        guard let itemId: String = "id" <~~ json,
            let name: String = "name" <~~ json,
            let imageUrl: URL = "image" <~~ json,
            let headline: String = "headline" <~~ json,
            let detailInformation: String = "description" <~~ json else {
                return nil
        }
        
        if let rating: Float = "rating" <~~ json {
            self.rating = rating
        }
        else {
            self.rating = 0.0
        }
        
        if let ratings: Int = "ratings" <~~ json {
            self.ratings = ratings
        }
        else {
            self.ratings = 0
        }
        
        self.itemId = itemId
        self.name = name
        self.imageUrl = imageUrl
        
        self.headline = headline
        self.favorite = false
        
        self.detailInformation = detailInformation
    }
    
    // MARK: - Serialization
    
    func toJSON() -> JSON? {
        return jsonify([JSON()])
    }
    
}

