//
//  ListItunesSearch.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

//{
//    "resultCount": 10,
//    "results": []
//}

class ListItunesMusicSearch: ObjectCodable {
   
    let resultCount: Int?
    let results: [ListItunesMusicSearchResult]?
    
    init(resultCount: Int?,
         results: [ListItunesMusicSearchResult]?) {
        
        self.resultCount = resultCount
        self.results = results
    }
    
}
