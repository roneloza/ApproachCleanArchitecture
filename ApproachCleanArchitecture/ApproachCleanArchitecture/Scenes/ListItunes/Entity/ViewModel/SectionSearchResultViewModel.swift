//
//  SectionSearchResultViewModel.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/12/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

class SectionSearchResultViewModel: ViewModelList {
    
    let resultCount: Int?
    
    init(resultCount: Int?) {
        
        self.resultCount = resultCount
    }
    
}
