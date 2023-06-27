//
//  DessertDetailCacheEntryObject.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/26/23.
//

import Foundation

// Class to cache network data
final class DessertDetailCacheManager{
    
    /// Variables instantiation and private initialization
    // Instantiate cache object with NSString as key and NSData as value
    private var cache = NSCache<NSString, NSData>()
    // Privat init
    init() {}
    
    /// Function to store data in cache
    /// - Parameters
    ///     - url: URL endpoint to interact with the MealDB Api
    ///     - data: data from endpoint
    public func setCache(url: URL?, data: Data) {
        if let url = url {
            let key = url.absoluteString as NSString
            // Store data object in cache with url as key
            cache.setObject(data as NSData, forKey: key)
        }
    }
    
    /// Function to retrieve cached object
    /// - Parameters
    ///     - url: URL endpoint to interact with the MealDB Api
    /// - Returns
    ///     - data: cached object if exists
    public func getCache(url: URL?) -> Data? {
        guard let url = url else { return nil }
        let key = url.absoluteString as NSString
        // Retrieve cached object with url as key
        return cache.object(forKey: key) as Data?
    }
    
}
