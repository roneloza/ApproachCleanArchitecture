//
//  ViewModelListable.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

protocol ViewModelListable {
    
    var items: [ViewModelListable]? { set get }
    var cellIdentifier: String? { set get }
}

extension ViewModelListable {
    
    var items: [ViewModelListable]? {
        set {

        }

        get {
            return nil
        }
    }

    var cellIdentifier: String? {
        set {

        }
        get {

            return nil
        }
    }
}

class ViewModelList: ObjectDebug, ViewModelListable {

    var items: [ViewModelListable]?
    var cellIdentifier: String?

//    init(items: [ViewModelListable]?,
//    cellIdentifier: String?) {
//
//        self.items = items
//        self.cellIdentifier = cellIdentifier
//    }
}

