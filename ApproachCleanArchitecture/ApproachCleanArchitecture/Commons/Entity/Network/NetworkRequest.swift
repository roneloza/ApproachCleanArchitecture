//
//  NetworkRequest.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

protocol NetworkRequest {
    
    var path: String {get}
    var method: NetworkHTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: String]? { get }
    var bodyFormData: [NetworkRequestablebBodyFormData]? { get }
    var bodyEncode: NetworkBodyEncode { get }
    var URLEncoding: NetworkURLEncode { get }
    var binary: Data? { get }
    var bodyFormDataBoundary: String { get }
}

extension NetworkRequest {
    
    var bodyFormDataBoundary: String {
        
        get {
         
            return "---011000010111000001101001"
        }
    }
    
    var headers: [String : String]? {
        
        switch self.bodyEncode {
            
        case .Form_Data:
            
            return ["content-type": "multipart/form-data; boundary=\(self.bodyFormDataBoundary)"]
            
        case .Form_URLEncoded:
            
            return ["content-type": "application/x-www-form-urlencoded"]
        case .Raw:
            
            return nil
        }
        
    }
    
    var parameters: [String: String]? {
        get {
            return nil
        }
    }
    
    var bodyFormData: [NetworkRequestablebBodyFormData]? {
        get {
            return nil
        }
    }
    
    var bodyEncode: NetworkBodyEncode {
        get {
            return .Form_URLEncoded
        }
    }
    
    var URLEncoding: NetworkURLEncode {
        get {
            return URLEncoding
        }
    }
    
    var binary: Data? {
        get {
            return nil
        }
    }
}

protocol NetworkRequestablebBodyFormData {
    
    var mimeType: NetworkRequestMimeType { set get }
    var key: String? { set get }
    var value: String? { set get }
    var filePath: String? { set get }
}

class NetworkRequestBodyFormData: NetworkRequestablebBodyFormData {
    
    var mimeType: NetworkRequestMimeType
    var key: String?
    var value: String?
    var filePath: String?
    
    init(mimeType: NetworkRequestMimeType,
         key: String?,
         value: String?,
         filePath: String?) {
        
        self.mimeType = mimeType
        self.key = key
        self.value = value
        self.filePath = filePath
    }
}

enum NetworkRequestMimeType: String {
    
    case jpg = "image/jpg"
    case mov = "video/mov"
    
    var fileExtension: String {
        
        switch self {
        case .jpg:
            return ".jpg"
            
        case .mov:
            return ".mov"
        }
    }
}

enum NetworkHTTPMethod {
    
    case GET
    case POST
    case PUT
    case HEAD
    case DELETE
    case PATCH
}

enum NetworkBodyEncode {
    
    case Raw
//    case Binary
    case Form_Data
    case Form_URLEncoded
}

enum NetworkURLEncode {
    
    case JSONEncoding
    case URLEncoding
}
