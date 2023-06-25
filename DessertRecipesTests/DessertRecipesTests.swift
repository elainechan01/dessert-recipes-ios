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
    func testBuildRequestFromService() {
        let request = MealdbRequest(endpoint: .filter, queryItems: ["c" : "Dessert"])
        MealdbService.shared.run(request, expecting: DessertList.self) { result in
            switch result {
            case .failure(let error):
                XCTFail(String(describing: error))
            case .success(let model):
                XCTAssertNotNil(String(describing: model))
            }
        }
    }
    

}
