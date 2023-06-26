//
//  DessertDetailCacheEntryObject.swift
//  DessertRecipes
//
//  Created by Elaine Chan on 6/26/23.
//

import Foundation

final class DessertDetailCacheEntryObject {
    
    let entry: DessertDetailCacheEntry
    
    init(entry: DessertDetailCacheEntry) {
        self.entry = entry
    }
    
}

enum DessertDetailCacheEntry {
    case inProgress(Task<DessertDetail, Error>)
    case ready(DessertDetail)
}
