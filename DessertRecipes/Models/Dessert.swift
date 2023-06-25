//
//  Dessert.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/23/23.
//

import Foundation

struct Dessert: Codable, Hashable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

struct DessertList: Codable, Hashable {
    let meals: [Dessert]
}

struct DessertDetail: Codable {
    var instructions: String
    var ingredients: [String]
}
