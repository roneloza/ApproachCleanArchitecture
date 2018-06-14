//
//  CellBindable.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/13/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

protocol CellBindable {
    
    associatedtype T
    
    func bind(viewModel: T)
}


//protocol CellBindable {
//    
//    func bind<T: ViewModelListable>(viewModel: T?)
//}

//extension CellBindable {
//    
//    func bind<T: ViewModelListable>(viewModel: T?) {
//        
//    }
//    
//}
