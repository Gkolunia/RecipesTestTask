//
//  RecipesTableConfiguratorTests.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/14/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import RecipesTestTask

class UITableViewMock: UITableView {
    
    var isReloaded = false
    
    override func reloadData() {
        super.reloadData()
        isReloaded = true
    }
    
}

class RecipeCellStub : RecipeCell {
    override func setup(with recipe: Recipe) {
        
    }
}

class RecipesTableConfiguratorTests: XCTestCase {
    
    var tableViewConfigurator: RecipesTableConfigurator!
    var tableViewMock: UITableViewMock!
    
    override func setUp() {
        super.setUp()
        tableViewMock = UITableViewMock()
        tableViewMock.register(RecipeCellStub.self, forCellReuseIdentifier: RecipeListConstants.kRecipeCellId)
        tableViewConfigurator = RecipesTableConfigurator(with: tableViewMock)
        
    }
    
    override func tearDown() {
        tableViewConfigurator = nil
        super.tearDown()
    }
    
    func testReloadTableView() {
        
        tableViewConfigurator.recipes = [RecipeModelStub.recipeStub!, RecipeModelStub.recipeStub!]
        
        XCTAssertTrue(tableViewMock.isReloaded, "After setting recipes dataSource tablew view should be reloaded")
        
    }
    
    func testDidSelectTableView() {
        let didSelect = expectation(description: "Did select")
        tableViewConfigurator.recipes = [RecipeModelStub.recipeStub!, RecipeModelStub.recipeStub2!]
        tableViewConfigurator.selectionHandler = {(item) -> () in
            
            XCTAssertTrue(item.itemId == RecipeModelStub.recipeStub2?.itemId, "Selected wrong item")
            
            didSelect.fulfill()
        }
        tableViewConfigurator.tableView.delegate?.tableView!(tableViewMock, didSelectRowAt: IndexPath(row: 1, section: 0))

        wait(for: [didSelect], timeout: 0.3)
        XCTAssertTrue(tableViewMock.isReloaded, "After setting recipes dataSource tablew view should be reloaded")
        
    }
    
    func testUpdateList() {
        
        tableViewConfigurator.recipes = [RecipeModelStub.recipeStub!, RecipeModelStub.recipeStub!]
        
        var detailModel = RecipeModelStub.recipeDetailsStub!
        detailModel.favorite = true
        detailModel.ratings = 99
        detailModel.ratedByMe = 5
        detailModel.rating = 3.3
        
        tableViewConfigurator.updateList(with: detailModel)
        
        let afterUpdateRecipe = tableViewConfigurator.recipes[0]
        
        XCTAssertTrue(afterUpdateRecipe.favorite == detailModel.favorite, "After update the propertty should be equal")
        XCTAssertTrue(afterUpdateRecipe.ratings == detailModel.ratings, "After update the propertty should be equal")
        XCTAssertTrue(afterUpdateRecipe.ratedByMe == detailModel.ratedByMe, "After update the propertty should be equal")
        XCTAssertTrue(afterUpdateRecipe.rating == detailModel.rating, "After update the propertty should be equal")
        
    }
    
}
