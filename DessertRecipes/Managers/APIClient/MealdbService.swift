//
//  MealdbService.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/24/23.
//

import Foundation

/// Class to perform requests to communicate with the MealDB APi
final class MealdbService {
    
    /// Variables instantiation and private initialization method
    // Instantiate class object
    static let shared = MealdbService()
    // Instantiate Cache Manager
    private let cacheManager = DessertDetailCacheManager()
    // Private init
    private init () {}
    
    /// Function to retrieve network data and handle response
    /// - Parameters
    ///     - request: MealdbRequest type
    ///     - expecting: Data type to decode to
    ///     - completion handler: Optional decoded result or thrown error
    ///  - Throws:
    ///     - MealdbServiceError.urlRequestBuildFail
    ///     - MealdbServiceError.urlSessionErrorReturned
    ///     - MealdbServiceError.invalidResponseReturned
    ///     - MealdbServiceError.decodingErrorReturned
    public func run<T: Codable>(
        _ request: MealdbRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        // Attempt to retrieve data from Cache Manager
        if let cachedData = cacheManager.getCache(url: request.url) {
            do {
                let decoded = try JSONDecoder().decode(type.self, from: cachedData)
                completion(.success(decoded))
            } catch {
                completion(.failure(MealdbServiceError.decodingErrorReturned))
            }
            return
        }
        
        // Build URLRequest from `request` parameter
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(MealdbServiceError.urlRequestBuildFail))
            return
        }
        
        // Build URLsession dataTask
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            // Handle any error
            if error != nil {
                completion(.failure(MealdbServiceError.urlSessionErrorReturned))
            }
            // Handle bad response
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            guard (200...299).contains(status) else {
                completion(.failure(MealdbServiceError.invalidResponseReturned))
                return
            }
            // Calls completion handler to decode data. Throw error if error is found.
            do {
                // Decode response as `expecting` data type
                let decoded = try JSONDecoder().decode(type.self, from: data!)
                // Store data in cache manager
                self?.cacheManager.setCache(url: request.url, data: data!)
                completion(.success(decoded))
            } catch {
                completion(.failure(MealdbServiceError.decodingErrorReturned))
            }
            
        }
        // Start URLSession dataTask
        task.resume()
    }
    
    /// Function to build URLSession with GET method
    /// - Parameters
    ///     - request: MealdbRequest type
    ///  - Returns
    ///     - request: URLRequest
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

/// Custom errors
/// - urlRequestBuildFail: Failed to build URLRequest
/// - urlSessionErrorReturned: Error was returned when building URLSession
/// - invalidResponseReturned: Bad response returned from API
/// - decodingErrorReturned: Unable to decode data from URLSession as `expecting` data type
extension MealdbService {
    enum MealdbServiceError: Error {
        case urlRequestBuildFail
        case urlSessionErrorReturned
        case invalidResponseReturned
        case decodingErrorReturned
    }
}
