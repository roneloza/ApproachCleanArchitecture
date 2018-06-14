//
//  FetchStatePresentable.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/11/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import UIKit

protocol FetchStatePresentable {
    
    func size(section: Int, row: Int, contentSize: CGFloat) -> CGFloat
    
    func sections<T: ViewModelListable>(data: [T]?) -> Int
    
    func rows<T: ViewModelListable>(section: Int, data: [T]?) -> Int
    
    func item<T: ViewModelListable>(section: Int, row: Int, data: [T]?) -> ViewModelListable?
    
    func cellIdentifier<T: ViewModelListable>(section: Int, row: Int, data: [T]?) -> String
}

extension FetchStatePresentable {
 
    func size(section: Int, row: Int, contentSize: CGFloat) -> CGFloat {
        
        return 0.0
    }
    
    func sections<T: ViewModelListable>(data: [T]?) -> Int {
        
        return 1
    }
    
    func rows<T: ViewModelListable>(section: Int, data: [T]?) -> Int {
        
        return 0
    }
    
    func item<T: ViewModelListable>(section: Int, row: Int, data: [T]?) -> ViewModelListable? {
        
        return nil
    }
    
//    func cellIdentifier<T: ViewModelListable>(section: Int, row: Int, data: [T]?) -> String? {
//
//        return nil
//    }
}


enum BaseFetchStatePresenter: FetchStatePresentable {
    
    case success
    case requesting
    case empty
    
    func size(section: Int, row: Int, contentSize: CGFloat) -> CGFloat {
        
        switch self {
        case .success:
            
            return UITableViewAutomaticDimension
        case .requesting:
            
            return 44.0
        case .empty:
            
            return contentSize
        }
    }
    
    
    func sections<T: ViewModelListable>(data: [T]?) -> Int {
        
        switch self {
        case .success:
            
            return data?.count ?? 1
        case .requesting:
            
            return 1
        case .empty:
            
            return 1
        }
    }
    
    func rows<T: ViewModelListable>(section: Int, data: [T]?) -> Int {
        
        switch self {
        case .success:
            
            var rows: Int = 0
            
            if let sec = data?[section],
                let items = sec.items {
                
                rows = items.count
            }
            
            return rows
        case .requesting:
            
            return 8
        case .empty:
            
            return 1
        }
    }
    
    func item<T: ViewModelListable>(section: Int, row: Int, data: [T]?) -> ViewModelListable? {
        
        switch self {
        case .success:
            
            if let sec = data?[section],
                let items = sec.items {
                
                return items[row]
            }
            
            return nil
        case .requesting:
            
            return nil
        case .empty:
            
            return nil
        }
    }
    
    func cellIdentifier<T: ViewModelListable>(section: Int, row: Int, data: [T]?) -> String {
        
        switch self {
        case .success:
            
            if let sec = data?[section],
                let items = sec.items,
                0 ..< items.count ~= row,
                let identifier = items[row].cellIdentifier {
                
                return identifier
            }
            
            return "Cell"
        case .requesting:
            
            return "Loading"
        case .empty:
            
            return "Empty"
        }
    }
}
