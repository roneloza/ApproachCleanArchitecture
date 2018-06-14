//
//  ListItunesInteractor.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/13/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

class ListItunesMusicInteractor: ObjectDebug  {
    
    private let output: ListItunesMusicInteractorOutput
    private let networkWorker: ItunesServiceWorkerType
    
    init(output: ListItunesMusicInteractorOutput,
         networkWorker: ItunesServiceWorkerType) {
        
        self.output = output
        self.networkWorker = networkWorker
    }
}

extension ListItunesMusicInteractor: ListItunesMusicInteractorInput {
    
    func fetchSearchItunes(with request: ListItunesMusicRequest) {
        
        self.networkWorker.fetchSearchItunes(with: request, success: { [unowned self] (model) in
            
            self.output.presentFetchSearchItunes(with: model)
        }) { [unowned self] (error) in
            
            self.output.presentFetchSearchItunesError(with: error)
        }
    }
}
