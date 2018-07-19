//
//  Recipe.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/10/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation
import Gloss

/**
 * @brief Recipe model for list controller.
 */
struct Recipe : Glossy {

    let itemId: String
    let name: String
    let imageUrl: URL
    var rating: Float
    var favorite: Bool
    let headline: String
    var ratedByMe: Int = 0
    var ratings: Int
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        guard let itemId: String = "id" <~~ json,
            let name: String = "name" <~~ json,
            let imageUrl: URL = "image" <~~ json,
            let headline: String = "headline" <~~ json else {
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
        
        if let favorites: Int = "favorites" <~~ json,
            favorites > 0 {
            self.favorite = true
        }
        else {
            self.favorite = false
        }
        
        
        
    }
    
    // MARK: - Serialization
    
    func toJSON() -> JSON? {
        return jsonify([JSON()])
    }

}

extension Recipe : Equatable {
    
    public static func ==(lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.itemId == rhs.itemId
    }
}
