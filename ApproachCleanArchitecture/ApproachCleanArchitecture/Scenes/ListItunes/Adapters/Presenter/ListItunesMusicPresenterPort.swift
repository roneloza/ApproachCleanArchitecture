//
//  ListItunesPresenterPort.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/13/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

protocol ListItunesMusicPresenterInput {
    
    func presentFetchSearchItunes(with model: ListItunesMusicSearch)
    func presentFetchSearchItunesError(with error: ErrorModelable)
}


protocol ListItunesMusicPresenterOutput: class {
    
    func displayFetchSearchItunes(with viewModel: ListItunesMusicViewModel)
    func displayFetchSearchItunesError(with error: ErrorViewModelable)
    
    var listViewModel: ListItunesMusicViewModel! { get set }
}
