//
//  NSCache+Subscript.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/26/23.
//

import Foundation

extension NSCache where KeyType == NSString, ObjectType == DessertDetailCacheEntryObject {
    subscript(_ id: String) -> DessertDetailCacheEntry? {
        get {
            let key = id as NSString
            let value = object(forKey: key)
            return value?.entry
        }
        set {
            let key = id as NSString
            if let entry = newValue {
                let value = DessertDetailCacheEntryObject(entry: entry)
                setObject(value, forKey: key)
            }
        }
    }
}
