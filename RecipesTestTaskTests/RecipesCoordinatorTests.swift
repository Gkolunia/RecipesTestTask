//
//  RecipesCoordinatorTests.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/14/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import RecipesTestTask

struct RecipeModelStub {
    static let recipeStub = Recipe(json: ["id"         : "1",
                                   "name"       : "Moroccan Skirt Steak",
                                   "image"      : "https://d3hvwccx09j84u.cloudfront.net/1024,0/image/53314247ff604d44808b4569.jpg",
                                   "headline"   : "with Sweet Potato Wedges and Minted Snap Peas",
                                   "rating"     : 2.0,
                                   "ratings"    : 1])
    
    static let recipeStub2 = Recipe(json: ["id"         : "2",
                                          "name"       : "Moroccan Skirt Steak",
                                          "image"      : "https://d3hvwccx09j84u.cloudfront.net/1024,0/image/53314247ff604d44808b4569.jpg",
                                          "headline"   : "with Sweet Potato Wedges and Minted Snap Peas",
                                          "rating"     : 2.0,
                                          "ratings"    : 1])
    
    static let recipeDetailsStub = RecipeDetails(json: ["id"         : "1",
                                                 "name"       : "Moroccan Skirt Steak",
                                                 "image"      : "https://d3hvwccx09j84u.cloudfront.net/1024,0/image/53314247ff604d44808b4569.jpg",
                                                 "headline"   : "with Sweet Potato Wedges and Minted Snap Peas",
                                                 "rating"     : 3.0,
                                                 "ratings"    : 2,
                                                 "description": "Description Text"])
}


class DidLogoutDelegateMock: RecipesCoordinatorDelegate {
    
    var logoutIsDone = false
    
    func doLogOut() {
        logoutIsDone = true
    }
}

class TableViewConfiguratorMock: RecipesTableConfigurator {
    
    var isUpdated = false

    override func updateList(with recipe: RecipeDetails) {
        isUpdated = true
    }
}

class RecipesCoordinatorTests: XCTestCase {
    
    var coordinator : RecipesCoordinator!
    var rootViewController : UINavigationController!
    var logoutCoordinatorDelegate : DidLogoutDelegateMock!
    
    override func setUp() {
        super.setUp()
        
        logoutCoordinatorDelegate = DidLogoutDelegateMock()
        rootViewController = UINavigationController()
        
        coordinator = RecipesCoordinator(with: logoutCoordinatorDelegate)
        coordinator.start(from: rootViewController, animated: false)
    }
    
    override func tearDown() {
        coordinator = nil
        rootViewController = nil
        logoutCoordinatorDelegate = nil
        super.tearDown()
    }
    
    func testStartCoordinatorConfiguration() {
        
        guard let recipesListController = rootViewController.topViewController as? RecipesTableViewController else {
            XCTFail("Wrong controller is presented on start recipes coordinator")
            return
        }
        
        guard let _ = recipesListController.recipesDataManager else {
            XCTFail("DataManager should be set in recipesList after coordinator start")
            return
        }
        
        XCTAssertTrue(recipesListController.delegate === coordinator, "Wrong delegate in recipesList controller")
        
        
    }
    
    func testDoLogout() {
        coordinator.recipesControllerDidLogout()
        XCTAssertTrue(logoutCoordinatorDelegate.logoutIsDone, "Logout should be done")
    }
    
    func testShowDetails() {
        coordinator.showDetails(with: RecipeModelStub.recipeStub!, from: rootViewController)
        
        let presentingDetails = expectation(description: "Pushing")
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            
            guard let detailsController = self.rootViewController.topViewController as? RecipeDetailsViewController else {
                XCTFail("DetailsController should be pushed after showing")
                return
            }
            
            guard let _ = detailsController.dataManager else {
                XCTFail("DataManager should be set in recipe details after coordinator show details")
                return
            }
            
            XCTAssertTrue(detailsController.delegate === self.coordinator, "Wrong delegate in signIn controller")
            
            XCTAssertNotNil(detailsController.recipe, "Recipe shouldn't be nil after showing")
        
            presentingDetails.fulfill()
            
        }
        wait(for: [presentingDetails], timeout: 0.4)
    }
    
    func testPopListAndUpdateRecipeInList() {
        coordinator.showDetails(with: RecipeModelStub.recipeStub!, from: rootViewController)
        let presentingDetails = expectation(description: "Pushing")
        let popDetails = expectation(description: "Pop")
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            
            guard let detailsController = self.rootViewController.topViewController as? RecipeDetailsViewController else {
                XCTFail("DetailsController should be pushed after showing")
                return
            }
            
            guard let listController = self.rootViewController.viewControllers[0] as? RecipesTableViewController else {
                XCTFail("ListController should be exist in stack")
                return
            }
            
            
            let configuratorMock = TableViewConfiguratorMock(with: listController.tableView)
            listController.tableViewConfigurator = configuratorMock
            
            self.coordinator.popViewControllerAndUpdateList(detailsController, with: RecipeModelStub.recipeDetailsStub!)
            
            XCTAssertTrue(configuratorMock.isUpdated, "Table view Configartor should be updated after recipe is edited")
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                popDetails.fulfill()
            }
            
            presentingDetails.fulfill()
            
        }
        
        wait(for: [presentingDetails, popDetails], timeout: 0.6)
        
    }
    
    
}
