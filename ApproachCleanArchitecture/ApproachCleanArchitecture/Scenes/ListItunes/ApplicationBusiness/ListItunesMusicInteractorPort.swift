//
//  ListItunesInteractorPort.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/13/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

protocol ListItunesMusicInteractorInput {
    
    func fetchSearchItunes(with request: ListItunesMusicRequest)
}

protocol ListItunesMusicInteractorOutput {
    
    func presentFetchSearchItunes(with model: ListItunesMusicSearch)
    func presentFetchSearchItunesError(with error: ErrorModelable)
}
