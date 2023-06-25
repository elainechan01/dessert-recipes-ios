//
//  DessertViewModel.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/24/23.
//

import UIKit
import SwiftUI

final class DessertViewModel: ObservableObject {
    
    @Published var meals: [Dessert] = []

    // Function to get all dessert meals and store as sorted alphabetically
    public func getAllDesserts() {
        let request = MealdbRequest(endpoint: .filter, queryItems: ["c" : "Dessert"])
        MealdbService.shared.run(request, expecting: DessertList.self) { result in
            switch result {
            case .failure(let error):
                print("Error found: \(error)")
            case .success(let model):
                let meals = model.meals
                self.meals = meals
                self.meals.sort(by: {$0.strMeal < $1.strMeal})
            }
        }
    }
    
}
