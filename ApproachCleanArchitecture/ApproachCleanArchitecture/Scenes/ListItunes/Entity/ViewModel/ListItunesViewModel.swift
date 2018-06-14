//
//  ListItunesViewModel.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

class ListItunesMusicViewModel {
    
    var sections: [SectionSearchResultViewModel]?
    let limit:Int = 25
    var state: ListItunesMusicFetchStatePresenter = ListItunesMusicFetchStatePresenter.empty
    
    init(sections: [SectionSearchResultViewModel]?) {
        
        self.sections = sections
    }
}
