//
//  DessertRecipesTests.swift
//  DessertRecipesTests
//
//  Created by Elaine Chan on 6/23/23.
//

import XCTest
@testable import DessertRecipes

/// Unit tests for basic app functionality
final class DessertRecipesTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    /// Module: APIClient > MealdbRequest
    // Function to test MealdbRequest create API request URL to filter
    func testBuildFilterUrl() {
        // Mock use filter endpoint
        let request = MealdbRequest(endpoint: .filter)
        // Check if built URL is equal to sample URL
        XCTAssertEqual(request.url, URL(string: "https://themealdb.com/api/json/v1/1/filter.php"))
    }
    // Function to test MealdbRequest create API request URL to filter all desserts
    func testBuildFilterDessertsUrl() {
        // Mock filter dessert meals
        let request = MealdbRequest(endpoint: .filter, queryItems: ["c" : "Dessert"])
        // Check if built URL is equal to sample URL
        XCTAssertEqual(request.url, URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"))
    }
    // Function to test MealdbRequest create API request URL to lookup dessert detail based on id
    func testBuildLookupDessertDetailUrl() {
        // Mock lookup idMeal 53042
        let request = MealdbRequest(endpoint: .lookup, queryItems: ["i" : "53042"])
        // Check if built URL is equal to sample URL
        XCTAssertEqual(request.url, URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=53042"))
    }
    
    /// Module: APIClient > MealdbService
    // Function to test MealdbService get all desserts
    func testFilterDesserts() {
        // Mock filter dessert meals
        var dessertList: [Dessert] = []
        // Build mock run
        let expectation = XCTestExpectation(description: #function)
        // Mock MealdbRequest
        let request = MealdbRequest(endpoint: .filter, queryItems: ["c": "Dessert"])
        // Mock MealdbService
        MealdbService.shared.run(request, expecting: DessertList.self) { result in
            switch result {
            // Fulfill XCTestExpectation only when a valid response is returned
            case .success(let model):
                dessertList = model.meals
                expectation.fulfill()
            case .failure:
                XCTFail("Test error: Dessert detail not retrieved")
            }
        }
        // Wait for mock run to be fulfilled
        wait(for: [expectation], timeout: 3.0)
        // Check if non empty array of meals is returned
        XCTAssert(dessertList.count > 0)
    }
    // Function to test MealdbService get dessert detail based on id
    func testLookupDessertDetail() {
        // Mock lookup idMeal 53042
        var dessertDetail: DessertDetail? = nil
        // Build mock run
        let expectation = XCTestExpectation(description: #function)
        // Mock MealdbRequest
        let request = MealdbRequest(endpoint: .lookup, queryItems: ["i": "53042"])
        // Mock MealdbService
        MealdbService.shared.run(request, expecting: DessertDetailList.self) { result in
            switch result {
            // Fulfill XCTestExpectation only when a valid response is returned
            case .success(let model):
                dessertDetail = model.meals.first
                expectation.fulfill()
            case .failure:
                XCTFail("Test error: Dessert detail not retrieved")
            }
        }
        // Wait for mock run to be fulfilled
        wait(for: [expectation], timeout: 3.0)
        // Check if dessert detail returned matches area source (Portuguese)
        XCTAssertEqual(dessertDetail?.strArea, "Portuguese")
    }
    
    /// Module: ViewModels > DessertViewModel
    // Function to test DessertViewModel filter all desserts with a mock run to filter all dessert meals
    func testFilterDessertsAsPublished() {
        // Mock DessertViewModel
        let dessertVM = DessertViewModel()
        // Build mock run
        let expectation = XCTestExpectation()
        // Check if getAllDesserts function retrieves data successfully and stores in observable object
        dessertVM.getAllDesserts()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // Check if data retrieved is no empty
            XCTAssert(dessertVM.dessertList.count > 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    /// Module: ViewModels > DessertDetailViewModel
    // Function to test DessertDetailViewModel to lookup a dessert detail based on id with a mock run to lookup idMeal 53042
    func testLookupDessertDetailAsPublished() {
        // Mock dessert to lookup
        let dessert = Dessert(strMeal: "Portuguese prego with green piri-piri", strMealThumb: "https://www.themealdb.com/images/media/meals/ewcikl1614348364.jpg", idMeal: "53042")
        // Mock DessertDetailViewModel
        let dessertDetailVM = DessertDetailViewModel(dessert: dessert)
        // Build mock run
        let expectation = XCTestExpectation()
        // Check if getDessertDetails function retrieves data successfully and stores in observable object
        dessertDetailVM.getDessertDetails()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // Check if dessert detail retrieved matches area source (Portuguese)
            XCTAssertEqual(dessertDetailVM.dessertDetail?.strArea, "Portuguese")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
}
