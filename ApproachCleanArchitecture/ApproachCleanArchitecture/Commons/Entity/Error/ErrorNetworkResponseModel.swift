//
//  ErrorNetworkResponseModel.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

class ErrorNetworkResponseModel : ObjectCodable {
    
    let message: String?
    
    init(message: String?) {
        
        self.message = message
    }
    
}
