//
//  Configurations.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

class Configuration {
    
    var baseURL = ""
    
    init() {
        
        if let dictionary = Bundle.main.infoDictionary,
            let configuration = dictionary["Configuration"] as? String,
            let path = Bundle.main.path(forResource: "Configurations", ofType: "plist") ,
            let config = NSDictionary(contentsOfFile: path) {
            
            for (key, value) in config {
                
                if let key = key as? String,
                    let value = value as? [String:String] {
                    
                    if key == configuration {
                        
                        self.baseURL = value["baseURL"] ?? ""
                    }
                }
            }
        }
    }
}
