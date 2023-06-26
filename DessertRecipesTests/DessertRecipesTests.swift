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
        var dessertList: [Dessert] = []
        let expectation = XCTestExpectation(description: #function)
        let request = MealdbRequest(endpoint: .filter, queryItems: ["c": "Dessert"])
        MealdbService.shared.run(request, expecting: DessertList.self) { result in
            switch result {
            case .success(let model):
                dessertList = model.meals
                expectation.fulfill()
            case .failure:
                XCTFail("Test error: Dessert detail not retrieved")
            }
        }
        wait(for: [expectation], timeout: 3.0)
        XCTAssert(dessertList.count > 0)
    }
    /// Function to test MealdbService get dessert detail based on id
    func testLookupDessertDetail() {
        var dessertDetail: DessertDetail? = nil
        let expectation = XCTestExpectation(description: #function)
        let request = MealdbRequest(endpoint: .lookup, queryItems: ["i": "53042"])
        MealdbService.shared.run(request, expecting: DessertDetailList.self) { result in
            switch result {
            case .success(let model):
                dessertDetail = model.meals.first
                expectation.fulfill()
            case .failure:
                XCTFail("Test error: Dessert detail not retrieved")
            }
        }
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(dessertDetail)
    }
    
    /// Module: ViewModels > DessertViewModel
    /// Function to test DessertViewModel filter all desserts
    func testFilterDessertsAsPublished() {
        let expectation = XCTestExpectation(description: "Published var is not nil")
        let dessertVM = DessertViewModel()
        let cancellable = dessertVM.$dessertList
            .dropFirst()
            .sink(receiveValue: { output in
                XCTAssert(output.count > 0)
            })
        dessertVM.getAllDesserts()
    }
    
    /// Module: ViewModels > DessertDetailViewModel
    /// Function to test DessertDetailViewModel to lookup a dessert detail based on id
    func testLookupDessertDetailAsPublished() {
        let dessert = Dessert(strMeal: "Portuguese prego with green piri-piri", strMealThumb: "https://www.themealdb.com/images/media/meals/ewcikl1614348364.jpg", idMeal: "53042")
        let expectation = XCTestExpectation(description: "Published var is not nil")
        let dessertDetailVM = DessertDetailViewModel(dessert: dessert)
        let cancellable = dessertDetailVM.$dessertDetail
            .dropFirst()
            .sink(receiveValue: { output in
                XCTAssertEqual(output?.strArea, "Portuguese")
            })
        dessertDetailVM.getDessertDetails()
    }
    
}
