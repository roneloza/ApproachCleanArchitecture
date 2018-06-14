//
//  AppDisplayable.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/13/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import UIKit

protocol AppDisplayable {
    
    func display(alert: AlertViewModel)
    func displayError(_ viewModel: ErrorViewModelable)
    func displayError(_ viewModel: ErrorViewModelable, handler: AlertActionCompletion?)
    
    func displaySheet(alert: AlertViewModel)
}

protocol AppDisplayableNative: AppDisplayable {
    
}

extension AppDisplayableNative where Self: UIViewController {
    
    func display(alert: AlertViewModel) {
        
        let alertController = UIAlertController.init(
            title: alert.title,
            message: alert.message,
            preferredStyle: .alert
        )
        
        if let actions = alert.actions {
            
            for action in actions {
                
                let style: UIAlertActionStyle
                
                switch action.style {
                    
                case .destructive:
                    
                    style = UIAlertActionStyle.destructive
                case .cancel:
                    
                    style = UIAlertActionStyle.cancel
                default:
                    
                    style = UIAlertActionStyle.default
                }
                
                alertController.addAction(
                    UIAlertAction.init(title: action.title, style: style, handler: { _ in
                        
                        action.handler?()
                    })
                )
            }
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func displayError(_ viewModel: ErrorViewModelable) {
        
        self.displayError(viewModel, handler: nil)
    }
    
    func displayError(_ viewModel: ErrorViewModelable, handler: AlertActionCompletion?) {
        
        self.display(alert: AlertViewModel(title: viewModel.title, message: viewModel.message, actions: [AlertAction(title: "Aceptar", handler: handler)]))
    }
    
    func displaySheet(alert: AlertViewModel) {
        
        let alertController = UIAlertController.init(
            title: alert.title,
            message: alert.message,
            preferredStyle: .actionSheet
        )
        
        if let actions = alert.actions {
            
            for action in actions {
                
                let style: UIAlertActionStyle
                
                switch action.style {
                    
                case .destructive:
                    
                    style = UIAlertActionStyle.destructive
                case .cancel:
                    
                    style = UIAlertActionStyle.cancel
                default:
                    
                    style = UIAlertActionStyle.default
                }
                
                alertController.addAction(
                    UIAlertAction.init(title: action.title, style: style, handler: { _ in
                        
                        action.handler?()
                    })
                )
            }
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
}
