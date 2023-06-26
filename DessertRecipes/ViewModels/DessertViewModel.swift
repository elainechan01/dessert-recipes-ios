//
//  DessertViewModel.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/24/23.
//

import UIKit
import SwiftUI

final class DessertViewModel: ObservableObject {

    @Published var dessertList: [Dessert]
    
    init () {
        self.dessertList = []
    }

    public func getAllDesserts() {
        let request = MealdbRequest(endpoint: .filter, queryItems: ["c": "Dessert"])
        MealdbService.shared.run(request, expecting: DessertList.self) { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error found: \(error)")
            case .success(let model):
                let meals = model.meals
                DispatchQueue.main.async {
                    self?.dessertList = meals
                }
            }
        }
    }
    
}
