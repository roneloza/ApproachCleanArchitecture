//
//  KeychainAccess.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation
import KeychainAccess

class KeychainAccessService: KeychainAccessible {
    
    private let keychain: Keychain
    
    required init(bundleId: String) {
        
        self.keychain = Keychain.init(service: bundleId)
    }
    
    func getString(_ key: String) -> String? {
        
        if let value = try? self.keychain.get(key) {
            
            return value
        }
        
        return nil
    }
    
    static func newUsingMainBundle() -> KeychainAccessible? {
        
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            
            return  KeychainAccessService.init(bundleId: bundleIdentifier)
        }
        
        return nil
    }
}

//enum KeychainManagerError: Error {
//    case InitializeError
//}

protocol KeychainAccessible {
    
    init(bundleId: String)
    
    func getString(_ key: String) -> String?
    
    static func newUsingMainBundle() -> KeychainAccessible?
}
