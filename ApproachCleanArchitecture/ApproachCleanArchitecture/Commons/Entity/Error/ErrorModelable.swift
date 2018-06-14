//
//  ErrorModelable.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

protocol ErrorModelable: Error {
    
    var title: String {get}
    var code: Int {get}
    var message: String {get}
    var data: Data? {get}
    var nestedErrorsCode: [ErrorModelable]? {get}
}

extension ErrorModelable {
    
    var data: Data? {
        
        get {
            return nil
        }
    }
    
    var nestedErrorsCode: [ErrorModelable]? {
        
        get {
            return nil
        }
    }
}
