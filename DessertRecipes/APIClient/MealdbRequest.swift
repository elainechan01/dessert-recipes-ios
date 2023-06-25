//
//  MealdbRequest.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/24/23.
//

import Foundation

/// Class to build a HTTP request to the MealDB API
final class MealdbRequest {
    
    // Set URLComponents: baseURL
    private struct Constants {
        static let scheme = "https"
        static let host = "themealdb.com"
    }
    // Set URL Components: path and parameters
    private let path: String
    private let queryItems: [URLQueryItem]
    init (
        endpoint: Endpoint,
        queryItems: [String:String] = [:]
    ) {
        self.path = "/api/json/v1/1/" + endpoint.rawValue
        self.queryItems = queryItems.map{
            return URLQueryItem(name: "\($0)", value: "\($1)")
        }
    }
    
    // Build URL using URLComponents
    public var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "themealdb.com"
        urlComponents.path = path
        if !queryItems.isEmpty{
            urlComponents.queryItems = queryItems
        }
        return urlComponents.url
    }
    
}

/// Handle different query use cases. Reference: https://themealdb.com/api.php @ June 2023
/// filter: return all meals based on attribute (e.g. area, category)
/// search: return meal details based on name
/// lookup: return meal details based on id
/// random: return a random meal's details
/// randomSelection: return a selection of 10 random meals
/// categories: return meal categories
/// list: return list of attributes (e.g. area, category)
enum Endpoint: String, CaseIterable {
    case filter = "filter.php"
    case search = "search.php"
    case lookup = "lookup.php"
    case random = "random.php"
    case randomSelection = "randomselection.php"
    case categories = "categories.php"
    case list = "list.php"
}

/// Init different functions for program usage
/// getAllDesserts: return all dessert meals
/// getDessertDetail: return dessert detail based on id
extension MealdbRequest {
    static let getAllDesserts = MealdbRequest(
        endpoint: .filter,
        queryItems: ["c": "Dessert"]
    )
}
