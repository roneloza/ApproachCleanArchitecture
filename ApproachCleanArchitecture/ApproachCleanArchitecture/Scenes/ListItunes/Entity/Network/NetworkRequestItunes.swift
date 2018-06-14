//
//  ListItunesNetworkRequest.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

enum NetworkRequestItunes: NetworkRequest {
    
//    https://itunes.apple.com/search?term=maroon&limit=10&country=pe&media=music&entity=album
    case fecthSearchItunes(terms: String, limit: Int)
//    case uploadPhoto(paramName: String, photoPath: String, type: NetworkRequestMimeType)
    
//    var bodyFormData: [NetworkRequestablebBodyFormData]? {
//        switch self {
//
//        case .uploadPhoto(let paramName, let photoPath, let type):
//
//            return [NetworkRequestBodyFormData.init(mimeType: type, key: paramName, value: nil, filePath: photoPath)]
//        default:
//
//            return nil
//        }
//    }
    
    var path: String {
        
        var endpointString = ""
        
        switch self {
            
        case .fecthSearchItunes:
            
            endpointString = "search"
            
            return endpointString
        }
    }
    
    var method: NetworkHTTPMethod {
        
        switch self {
            
        case .fecthSearchItunes:
            
            return .GET
        }
    }
    
    var parameters: [String: String]? {
        
        switch self {
            
        case .fecthSearchItunes(let terms, let limit):
            
            return [
                "term": terms,
                "limit": "\(limit)"
            ]
        }
    }
}
