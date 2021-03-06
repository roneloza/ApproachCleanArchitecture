//
//  ListItunesRequest.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

class ListItunesMusicRequest {
    
    let networkRequest: NetworkRequest
    let term: String
    let limit: Int
    
    init(networkRequest: NetworkRequest,
         term: String,
         limit: Int) {
        
        self.networkRequest = networkRequest
        self.term = term
        self.limit = limit
    }
}
