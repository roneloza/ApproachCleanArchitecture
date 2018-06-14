//
//  NetworkDispatcher.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

protocol NetworkDispatcher {
    
    var keychain: KeychainAccessible? { get }
    var headersDeaults:[String: String] { get }
    var baseURLDeaults: String? { get }
    
    func requestBase(request: NetworkRequest, success: @escaping (Data?) -> Void, failure: @escaping (ErrorModelable) -> Void)
}

extension NetworkDispatcher {
    
    var keychain: KeychainAccessible? {
        get {
            
            return nil
        }
    }
    
    var baseURLDeaults: String? {
        get {
            
            return nil
        }
    }
    
    var headersDeaults:[String: String] {
        
        get {
            
            if let keychain = self.keychain,
                let authToken = keychain.getString("auth_token"),
                let tokenType = keychain.getString("type_token") {
                
                let authorizationHeader = tokenType + " " + authToken
                
                return ["Authorization" : authorizationHeader,
                        "Content-Type": "application/json",
                        "Accept": "application/json"]
            }
            else {
                
                return ["Authorization" : "",
                        "Content-Type": "application/json",
                        "Accept": "application/json"]
            }
        }
    }
    
    func requestBase(request: NetworkRequest, success: @escaping (Data?) -> Void, failure: @escaping (ErrorModelable) -> Void) {

    }
}

class BaseNetworkDispatcher: ObjectDebug, NetworkDispatcher {
 
    lazy var keychain: KeychainAccessible? = {
        
        return KeychainAccessService.newUsingMainBundle()
    }()
    
    private lazy var config: Configuration = {
        
        return Configuration.init()
    }()
    
    var baseURLDeaults: String? {
        get {
            
            return self.config.baseURL
        }
    }
    
    func requestBase(request: NetworkRequest, success: @escaping (Data?) -> Void, failure: @escaping (ErrorModelable) -> Void) {

    }
}
