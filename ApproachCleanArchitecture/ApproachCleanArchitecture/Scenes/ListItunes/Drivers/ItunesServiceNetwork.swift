//
//  ItunesServiceNetwork.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

class ItunesServiceNetwork {
    
    private let dispatcher: NetworkDispatcher
    private let serializable: SerializableService
    
    init(dispatcher: NetworkDispatcher,
         serializable: SerializableService) {
        
        self.dispatcher = dispatcher
        self.serializable = serializable
    }
}

extension ItunesServiceNetwork: ItunesServiceWorkerType {

    func fetchSearchItunes(with request: ListItunesMusicRequest, success: @escaping (ListItunesMusicSearch) -> Void, failure: @escaping (ErrorModelable) -> Void) {
        
        self.dispatcher.requestBase(request: request.networkRequest, success: { data in
            
            if let jsonData = data {
                
                if let model = self.serializable.decodeCodable(with: jsonData, type: ListItunesMusicSearch.self) {
                    
                    success(model)
                }
                else {
                    
                    failure(ListItunesBussinessError.FailDataDeserialize)
                }
            }
            else {
                
                failure(ListItunesBussinessError.EmptyData)
            }
        }) { (error) in
            
            if error is RequestError {
                
                if let dataError = error.data {
                    
                    let errorModel = self.serializable.decodeCodable(with: dataError, type: ErrorNetworkResponseModel.self)
                    
                    failure(ListItunesBussinessError.FailRequest(message: errorModel?.message ?? "", statusCode: error.code))
                }
                else {
                    
                    failure(ListItunesBussinessError.FailRequest(message: error.message, statusCode: error.code))
                }
            }
            else {
                
                failure(ListItunesBussinessError.Unhandled)
            }
        }
    }
    
}
