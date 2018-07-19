//
//  RecipesDataManager.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/13/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation
import Gloss

enum GetListResult<T: Glossy> {
    case success([T])
    case failure(Error)
}

enum GetObjectResult<T: Glossy> {
    case success(T)
    case failure(Error)
}

/**
 * @brief DataManager protocol - define base inteface of data manger which can get list of objects which is implement protocol Glossy.
 * @see Glossy
 */
protocol DataManagerProtocol {
    
    /**
     * @brief The method - for getting parsed objects from some where.
     * @see Glossy
     */
    func getList<T: Glossy>(from jsonFileName: String, completionHandler: @escaping (GetListResult<T>) -> () )
}

/**
 * @brief DataManager - implement all needs getting data methods for application.
 * @see RecipesDataMangerProtocol
 * @see RecipeDetailsDataMangerProtocol
 */
class DataManager : DataManagerProtocol, RecipesDataMangerProtocol, RecipeDetailsDataMangerProtocol {
    
    /**
     * @brief Method just get data from local json file and parse its content to array of objects.
     */
    func getList<T: Glossy>(from jsonFileName: String, completionHandler: @escaping (GetListResult<T>) -> () ) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            let stringUrl = Bundle.main.path(forResource: jsonFileName, ofType: "json")
            
            let url = URL(fileURLWithPath: stringUrl!)
            
            do {
                
                let data = try Data(contentsOf: url)
                
                do {
                    
                    let jsonObject = try JSONSerialization.jsonObject(with: data)
                    
                    guard let array = jsonObject as? [JSON] else {
                        print("Wrong json type")
                        fatalError()
                    }
                
                    guard let arrayDecoded = [T].from(jsonArray: array) else {
                        print("Error decoding")
                        fatalError()
                    }
                    
                    DispatchQueue.main.async {
                        completionHandler(.success(arrayDecoded))
                    }
                    
                }
                catch {
                    print("Error serilization")
                    fatalError()
                }
                
            }
            catch {
                print("Error reading file")
                fatalError()
            }
        }
        
    }
    
    /**
     * @brief Method get list of recipes and pass through completionHandler.
     */
    func getRecipes(completionHandler: @escaping (GetListResult<Recipe>) -> ()) {
        getList(from: "recipes", completionHandler: completionHandler)
    }
    
    /**
     * @brief Method get list of recipes and pass through completionHandler.
     */
    func getFavorites(completionHandler: @escaping (GetListResult<Recipe>) -> ()) {
        getList(from: "recipes") { (result : GetListResult<Recipe>) in
            switch result {
            case .success(let array):
                let favorites = array.filter{ $0.favorite }
                completionHandler(.success(favorites))
            case .failure( _):
                completionHandler(result)
            }
            
        }
    }
    
    /**
     * @brief Method get particular recipeDetails and updated old data.
     */
    func getRecipeDetails(by recipe: Recipe, completionHandler: @escaping (GetObjectResult<RecipeDetails>) -> ()) {
        getList(from: "recipes") { ( result: GetListResult<RecipeDetails>) in
            
            switch result {
            case .success(let array):
                let foundItems = array.filter { $0.itemId == recipe.itemId }
                if foundItems.count > 0 {
                    var recipeDetails = foundItems.first! // I know it is bad to do it here. It just done for simulating data from server.
                    recipeDetails.ratedByMe = recipe.ratedByMe
                    recipeDetails.favorite = recipe.favorite
                    completionHandler(.success(recipeDetails))
                }
                else {
                    let error = NSError(domain: "App", code: 2, userInfo: [NSLocalizedDescriptionKey : "Recipe with id = "+recipe.itemId+"is not found."])
                   completionHandler(.failure(error))
                }
                
            case .failure(let error):
                completionHandler(.failure(error))
            }
  
        }
    }
    
    
}
