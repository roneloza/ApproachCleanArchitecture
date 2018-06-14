//
//  RequestError.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

enum BusinnessRequestErrorCode: Int {
    
    case FailWithText = 1001
    case FailWithData = 1002
    case EmptyData = 1003
    case EmptyNetworkResponse = 1004
    case FailURLMalformed = 1005
    case Unhandled = 1000
    
    init?(intValue: Int) {
        
        switch intValue {
        case 1001: self = .FailWithText
        case 1002: self = .FailWithData
        case 1003: self = .EmptyData
        case 1004: self = .EmptyNetworkResponse
        case 1005: self = .FailURLMalformed
        case 1000: self = .Unhandled
            
        default:
            return nil
        }
    }
}

enum RequestError: ErrorModelable {
    
    case FailWithText(message: String, httpStatus: Int)
    case FailWithData(data: Data, httpStatus: Int)
    case EmptyData(httpStatus: Int)
    case FailURLMalformed
    case EmptyNetworkResponse
    
    var title: String {
        
        switch self {
            
        default:
            return "Request Error"
        }
    }
    
    var code: Int {
        
        switch self {
            
        case .FailWithText(_, let httpStatus):
            
            return httpStatus
            
        case .FailWithData(_, let httpStatus):
            
            return httpStatus
            
        case .EmptyData(let httpStatus):
            
            return httpStatus
            
        case .EmptyNetworkResponse:
            
            return BusinnessRequestErrorCode.EmptyNetworkResponse.rawValue
            
        case .FailURLMalformed:
            
            return BusinnessRequestErrorCode.FailURLMalformed.rawValue
        }
    }
    
    var message: String {
        
        switch self {
            
        case .FailWithText(let message, let statusCode):
            
            let defaultMessage = "HTTP Status Code: \(statusCode)\nLa petición al servidor fallo"
            
            return message.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0 ? message : defaultMessage
            
        case .FailWithData(_, let statusCode):
            
            let defaultMessage = "HTTP Status Code: \(statusCode)\nLa petición al servidor fallo"
            
            return defaultMessage
            
        case .EmptyData(let statusCode):
            
            let defaultMessage = "HTTP Status Code: \(statusCode)\nLa petición al servidor fallo respuesta zero bytes"
            
            return defaultMessage
            
        case .EmptyNetworkResponse:
            
            return "La petición al servidor fallo no devuelve respuesta"
            
        case .FailURLMalformed:
            
            return "La url no esta bien formateada"
        }
    }
    
    var data: Data? {
        
        switch self {
            
        case .FailWithData(let data, _):
            
            return data
            
        default:
            
            return nil
        }
    }
}
