//
//  Alert.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/13/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

enum AlertActionStyle : Int {
    
    case `default`
    case cancel
    case destructive
}

class AlertViewModel {
    let title: String?
    let message: String?
    let actions: [AlertAction]?
    
    init(
        title: String?,
        message: String?,
        actions: [AlertAction]?) {
        
        self.title = title
        self.message = message
        self.actions = actions
    }
}

typealias AlertActionCompletion = (() -> Void)

class AlertAction {
    
    let title: String?
    let handler: AlertActionCompletion?
    var style: AlertActionStyle = .default
    
    init(title: String?,
         handler: AlertActionCompletion?) {
        
        self.title = title
        self.handler = handler
    }
    
    convenience init(title: String?,
                     style: AlertActionStyle,
                     handler: AlertActionCompletion?) {
        
        self.init(title: title, handler: handler)
        self.style = style
    }
}
