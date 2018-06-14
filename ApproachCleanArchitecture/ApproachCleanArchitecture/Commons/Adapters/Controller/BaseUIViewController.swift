//
//  File.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/12/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import UIKit

protocol BSTextFieldDisplayable: class {
    
    func keyboardWillShowNotification(keyboardSize: CGRect)
    func keyboardWillShow(convertRectViewToMove: CGRect)
    func keyboardWillHideNotification(keyboardSize: CGRect)
    var isKeyboardObserved: Bool { get }
    var viewToMoveOnShowKeyboard: UIView? { get }
}

//MARK: - Interface Adapters -
extension BaseUIViewController: AppDisplayableNative {}

class BaseUIViewController: UIViewController, BSTextFieldDisplayable {
    
    var isKeyboardObserved: Bool {
        
        get {
            return false
        }
    }
    
    var viewToMoveOnShowKeyboard: UIView? {
        
        get {
            return nil
        }
    }
    
    deinit {
        
        print("deinit : \(type(of: self))")
    }
    
    @IBAction func unwindToPresenter(_ sender: UIStoryboardSegue) {
        //        let sourceViewController = sender.source
        // Use data from the view controller which initiated the unwind segue
        
        performSegue(withIdentifier: "unwindSegue", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (self.isKeyboardObserved) {
            
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowObserverNotification(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideObserverNotification(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (self.isKeyboardObserved) {
            
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }
    
    func keyboardWillShowNotification(keyboardSize: CGRect) {
        
    }
    
    func keyboardWillHideNotification(keyboardSize: CGRect) {
        
    }
    
    func keyboardWillShow(convertRectViewToMove: CGRect) {
        
    }
}

private extension BaseUIViewController {
    
    @objc func keyboardWillShowObserverNotification(notification: NSNotification) {
        
        if let keyboardEndFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            self.keyboardWillShowNotification(keyboardSize: keyboardEndFrame)
            
            let convertRectViewToMove = self.view.convert(keyboardEndFrame, to: self.viewToMoveOnShowKeyboard)
            
            self.keyboardWillShow(convertRectViewToMove: convertRectViewToMove)
        }
    }
    
    @objc func keyboardWillHideObserverNotification(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            self.keyboardWillHideNotification(keyboardSize: keyboardSize)
        }
        else {
            
            self.keyboardWillHideNotification(keyboardSize: CGRect.zero)
        }
    }
}
