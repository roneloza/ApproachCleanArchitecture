//
//  ListItunesViewControllerInput.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

protocol ListItunesMusicViewControllerInput {
    
    func displayFetchSearchItunes(with viewModel: ListItunesMusicViewModel)
    func displayFetchSearchItunesError(with error: ErrorViewModelable)
    
    var listViewModel: ListItunesMusicViewModel! { get set }
}

protocol ListItunesMusicViewControllerOutput {
    
    func fetchSearchItunes(with request: ListItunesMusicRequest)
}
