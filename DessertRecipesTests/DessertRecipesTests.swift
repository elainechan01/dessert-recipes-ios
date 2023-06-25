//
//  DessertRecipesTests.swift
//  DessertRecipesTests
//
//  Created by Elaine Chan on 6/23/23.
//

import XCTest
@testable import DessertRecipes

final class DessertRecipesTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /// Module: APIClient > MealdbRequest
    /// Function to test MealdbRequest create API request URL to filter
    func testBuildFilterUrl() {
        let request = MealdbRequest(endpoint: .filter)
        XCTAssertEqual(request.url, URL(string: "https://themealdb.com/api/json/v1/1/filter.php"))
    }
    /// Function to test MealdbRequest create API request URL to filter all desserts
    func testBuildFilterDessertsUrl() {
        let request = MealdbRequest(endpoint: .filter, queryItems: ["c" : "Dessert"])
        XCTAssertEqual(request.url, URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"))
    }
    
    /// Module: APIClient > MealdbService
    /// Function to test MealdbService get all desserts
    func testFilterDesserts() {
        let request = MealdbRequest(endpoint: .filter, queryItems: ["c" : "Dessert"])
        MealdbService.shared.run(request, expecting: DessertList.self) { result in
            switch result {
            case .success(let model):
                if model.meals.count > 0 {
                    print("Test model \(model.meals)")
                }
            case .failure(let error):
                XCTFail("Test error: \(error)")
            }
        }
    }
    
    /// Module: APIClient > MealdbService
    /// Function to test MealdbService get dessert detail based on id
    func testLookupDessert() {
        let request = MealdbRequest(endpoint: .lookup, queryItems: ["i" : "53042"])
        MealdbService.shared.run(request, expecting: DessertDetailList.self) { result in
            switch result {
            case .success(let model):
                XCTAssertNotNil(model)
            case .failure(let error):
                XCTFail("Test error: \(error)")
            }
        }
    }
    
}
