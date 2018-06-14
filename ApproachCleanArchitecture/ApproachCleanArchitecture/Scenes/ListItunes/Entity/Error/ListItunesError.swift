//
//  ListItunesBussinessError.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

enum ListItunesBussinessErrorCode: Int {
    
    case EmptyData = 1101
    case FailDataDeserialize = 1102
    case FailRequest = 1103
    case Unhandled = 1100
    
    init?(intValue: Int) {
        
        switch intValue {
        case 1101: self = .EmptyData
        case 1102: self = .FailDataDeserialize
        case 1103: self = .FailRequest
        case 1100: self = .Unhandled
            
        default:
            return nil
        }
    }
}

enum ListItunesBussinessError: ErrorModelable {
    
    case EmptyData
    case FailDataDeserialize
    case FailRequest(message: String, statusCode: Int)
    case Unhandled
    
    var title: String {
        
        switch self {
            
        default:
            return "Bussiness Error"
        }
    }
    
    var code: Int {
        
        switch self {
            
        case .EmptyData:
            return ListItunesBussinessErrorCode.EmptyData.rawValue
            
        case .FailDataDeserialize:
            return ListItunesBussinessErrorCode.FailDataDeserialize.rawValue
            
        case .FailRequest:
            return ListItunesBussinessErrorCode.FailRequest.rawValue
            
        case .Unhandled:
            return ListItunesBussinessErrorCode.Unhandled.rawValue
        }
    }
    
    var message: String {
        
        switch self {
            
        case .EmptyData:
            return "BSBusinnessCheckoutError.EmptyData"
            
        case .FailDataDeserialize:
            return "BSBusinnessCheckoutError.FailDataDeserialize"
            
        case .FailRequest(let message, let statusCode):
            return """
            Mensaje : \(message) \n
            Status HTTTP Code : \(statusCode)
            """
            
        case .Unhandled:
            return "BSBusinnessCheckoutError.Unhandled"
        }
    }
}

enum ListItunesPresentationError: ErrorViewModelable {
    
    case EmptyData
    case FailDataDeserialize
    case FailRequest(message: String)
    case Unhandled
    
    init?(bussinessError: ErrorModelable) {
        
        switch bussinessError.code {
            
        case ListItunesBussinessErrorCode.EmptyData.rawValue : self = .EmptyData
        case ListItunesBussinessErrorCode.FailDataDeserialize.rawValue : self = .FailDataDeserialize
        case ListItunesBussinessErrorCode.FailRequest.rawValue : self = .FailRequest(message: bussinessError.message)
        case ListItunesBussinessErrorCode.Unhandled.rawValue : self = .Unhandled
            
        default:
            return nil
        }
    }
    
    var title: String {
        
        switch self {
            
        default:
            return "Presentation Error"
        }
    }
    
    var message: String {
        
        switch self {
            
        case .EmptyData:
            return "Los datos de la petición no existen o esta vacia"
            
        case .FailDataDeserialize:
            return "La deserialización de los datos fallo"
            
        case .FailRequest(let message):
            return message
            
        case .Unhandled:
            return "Error no identificado"
        }
    }
}
