//
//  DessertViewModel.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/24/23.
//

import UIKit

/// Class to implement business logic for Dessert model
final class DessertViewModel: ObservableObject {

    /// Variable instantiation and private initialization method
    // Create observable object list of Dessert
    @Published var dessertList: [Dessert] = []
    // Private init
    init () {}

    /**
     Function to filter all dessert meals
     Exampled response:
     {
         "meals": [
             {
                 "strMeal": "Apam balik",
                 "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
                 "idMeal": "53049"
             },
     }
     */
    public func getAllDesserts() {
        // Build MealdbRequest. Reference: https://themealdb.com/api.php @ June 2023
        //  e.g. https://themealdb.com/api/json/v1/1/filter.php?c=Dessert
        let request = MealdbRequest(endpoint: .filter, queryItems: ["c": "Dessert"])
        // Build MealdbService with DessertList expected type
        MealdbService.shared.run(request, expecting: DessertList.self) { [weak self] result in
            switch result {
            // Handle errors thrown - print to console
            case .failure(let error):
                print("Error found: \(error)")
            // Parse meals from response
            case .success(let model):
                let meals = model.meals
                DispatchQueue.main.async {
                    // Store response in observable object
                    self?.dessertList = meals
                }
            }
        }
    }
    
}
