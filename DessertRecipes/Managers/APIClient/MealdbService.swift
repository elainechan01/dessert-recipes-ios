//
//  MealdbService.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/24/23.
//

import Foundation

final class MealdbService {
    
    static let shared = MealdbService()
    
    //
    private init () {}
    
    // Function to
    public func run<T: Codable>(
        _ request: MealdbRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(MealdbServiceError.urlRequestBuildFail))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            // Handle error
            if error != nil {
                completion(.failure(MealdbServiceError.urlSessionErrorReturned))
            }
            // Handle invalid response
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            guard (200...299).contains(status) else {
                completion(.failure(MealdbServiceError.invalidResponseReturned))
                return
            }
            
            // Decode JSON response
            let data = data
            do {
                let decoded = try JSONDecoder().decode(type.self, from: data!)
                completion(.success(decoded))
            } catch {
                completion(.failure(MealdbServiceError.decodingErrorReturned))
                return
            }
            
        }
        task.resume()
    }
    
    // Function to create MealdbRequest
    private func request(from request: MealdbRequest) -> URLRequest? {
        
        // Retrieve URL from MealdbRequest
        guard let url = request.url else {
            print("Error: Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
        
    }
    
}

/// Error handling
extension MealdbService {
    enum MealdbServiceError: Error {
        case urlRequestBuildFail
        case urlSessionErrorReturned
        case invalidResponseReturned
        case decodingErrorReturned
    }
}
