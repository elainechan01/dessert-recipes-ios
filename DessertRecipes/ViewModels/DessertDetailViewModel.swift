//
//  DessertDetailViewModel.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/25/23.
//

import Foundation


final class DessertDetailViewModel: ObservableObject {
    
    @Published var dessertDetail: DessertDetail? = nil
    
    private let dessert: Dessert
    init (dessert: Dessert) {
        self.dessert = dessert
    }
    
    public func getDessertDetails() {
        let request = MealdbRequest(endpoint: .lookup, queryItems: ["i": dessert.idMeal])
        MealdbService.shared.run(request, expecting: DessertDetailList.self) { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error found: \(error)")
            case .success(let model):
                let dessertDetail = model.meals
                DispatchQueue.main.async {
                    self?.dessertDetail = dessertDetail.first
                }
            }
        }
    }
    
}
