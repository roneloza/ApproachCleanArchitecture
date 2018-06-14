//
//  ObjectDebugable.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

protocol ObjectDebugable {
    
}

class ObjectDebug: ObjectDebugable {
    
    deinit {
        
        print("deinit : \(type(of: self))" )
    }
}
