//
//  ItunesService.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

protocol ItunesService {
    
    func fetchSearchItunes(with request:ListItunesMusicRequest, success: @escaping (ListItunesMusicSearch) -> Void, failure: @escaping (ErrorModelable) -> Void)
}

protocol ItunesServiceWorkerType: ItunesService {
    
}
