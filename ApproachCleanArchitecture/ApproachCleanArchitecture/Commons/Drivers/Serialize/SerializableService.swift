//
//  SerializableService.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

protocol SerializableService {
    
    func decodeCodable<T: ObjectCodable>(with jsonData: Data?, type: T.Type) -> T?
    
    func decodeCodable<T: ObjectCodable>(with jsonData: Data?, key jsonKey: String, type: T.Type) -> T?
}

extension SerializableService {
    
    func decodeCodable<T: ObjectCodable>(with jsonData: Data?, type: T.Type) -> T? {
        
        if let data = jsonData {
            
            if let model: T = try? JSONDecoder().decode(T.self, from: data) {
                
                return model
            }
        }
        
        return nil;
    }
    
    func decodeCodable<T: ObjectCodable>(with jsonData: Data?, key jsonKey: String, type: T.Type) -> T? {
        
        if let data = jsonData {
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) {
                
                if let root = json as? Dictionary<String, Any?> {
                    
                    if let object = root[jsonKey] as? Dictionary<String, Any?> {
                        
                        if let objectData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) {
                            
                            return decodeCodable(with: objectData, type: T.self)
                        }
                        
                    }
                }
            }
        }
        
        return nil;
    }
}

