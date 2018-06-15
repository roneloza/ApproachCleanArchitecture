//
//  UITextField+Custom.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/13/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import UIKit

class UITextOptions: TextFieldInputValidable {
    
    var maxLength: Int = 0
    var removeEmoji: Bool = false
    var trimming: Bool = false
    var digitsFormat: Bool = false
    var dateFormat: Bool = false
    var separatorDateFormat: String = "/"
    var maxLengthDateFormat: Int = 0
    var dxInset: CGFloat = 0.0
}

protocol TextFieldInputValidable {
    
    var maxLength: Int {set get}
    var removeEmoji: Bool {set get}
    var trimming: Bool {set get}
    var digitsFormat: Bool {set get}
    var dateFormat: Bool {set get}
    var separatorDateFormat: String {set get}
    var maxLengthDateFormat: Int {set get}
}

protocol TextFieldStyle {
    
    var dxInset: CGFloat {set get}
}

extension UITextField: TextFieldStyle {
    
    @IBInspectable var dxInset: CGFloat {
        
        get {
            
            return self.configuration?.dxInset ?? 0.0
        }
        
        set {
            
            self.initTextField()
            self.configuration?.dxInset = newValue
        }
    }
}

extension UITextField: TextFieldInputValidable {
    
    private struct AssociatedKeys {
        static var configuration = "configuration"
    }
    
    private var configuration: UITextOptions? {
        
        get { return objc_getAssociatedObject(self, &AssociatedKeys.configuration) as? UITextOptions }
        set { objc_setAssociatedObject(self, &AssociatedKeys.configuration, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private func initTextField() {
        
        if configuration == nil {
            setupTextField()
        }
    }
    
    // MARK: - Private
    private func setupTextField() {
        
        self.configuration = UITextOptions.init()
        
        weak var wkself = self
        
        self.addTarget(wkself, action: #selector(self.textFieldEditingDidChange(_:)), for: UIControlEvents.editingChanged);
    }
    
    @IBInspectable var trimming: Bool {
        get {
            
            return self.configuration?.trimming ?? false
        }
        set {
            
            self.initTextField()
            self.configuration?.trimming = newValue
        }
    }
    @IBInspectable var maxLength: Int {
        
        get {
            
            return self.configuration?.maxLength ?? 0
        }
        
        set {
            
            self.initTextField()
            self.configuration?.maxLength = newValue
        }
    }
    
    @IBInspectable var removeEmoji: Bool {
        
        get {
            
            return self.configuration?.removeEmoji ?? false
        }
        
        set {
            
            self.initTextField()
            self.configuration?.removeEmoji = newValue
        }
    }
    
    @IBInspectable var digitsFormat: Bool {
        get {
            
            return self.configuration?.digitsFormat ?? false
        }
        
        set {
            
            self.initTextField()
            self.configuration?.digitsFormat = newValue
        }
    }
    
    @IBInspectable var dateFormat: Bool {
        get {
            
            return self.configuration?.dateFormat ?? false
        }
        
        set {
            
            self.initTextField()
            self.configuration?.dateFormat = newValue
        }
    }
    
    @IBInspectable var maxLengthDateFormat: Int {
        get {
            
            return self.configuration?.maxLengthDateFormat ?? 0
        }
        
        set {
            
            self.initTextField()
            self.configuration?.maxLengthDateFormat = newValue
        }
    }
    
    @IBInspectable var separatorDateFormat: String {
        get {
            
            return self.configuration?.separatorDateFormat ?? "/"
        }
        
        set {
            
            self.initTextField()
            self.configuration?.separatorDateFormat = newValue
        }
    }
    
    private func textDidChangeMaxLength(_ text: String, len: Int) -> String {
        
        var newText = text
        
        if len > 0 &&
            newText.count >= len  {
            
            newText = String(newText.prefix(len))
        }
        
        return newText
    }
    
    @objc private func textFieldEditingDidChange(_ sender: UITextField) {
        
        if var text = self.text {
            
            if self.trimming {
                
                let newValue = text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0 ? text : text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                text = newValue
            }
            
            if self.maxLength > 0  {
                
                let newValue = self.textDidChangeMaxLength(text, len: self.maxLength)
                
                text = newValue
            }
            
            if self.removeEmoji {
                
                let newValue = text.stringRemoveCharartersEmoji()
                
                text = newValue
            }
            
            if self.digitsFormat {
                
                let newValue = text.stringOnlyDigits()
                
                text = newValue
            }
            
            if self.dateFormat && self.maxLengthDateFormat == 0 {
                
                let separator = self.separatorDateFormat
                text = text.stringFormatDate(separator: separator, atIndex: 2)
            }
            
            if self.dateFormat && self.maxLengthDateFormat > 0 {
                
                let separator = self.separatorDateFormat
                text = text.stringFormatDate(separator: separator, atIndex: 2)
                
                var validText = text.stringOnlyDigits()
                
                if validText.count > self.maxLengthDateFormat,
                    let range = text.range(of: separator) {
                    
                    validText = self.textDidChangeMaxLength(validText, len: self.maxLengthDateFormat)
                    validText.insert(contentsOf: separator, at: range.lowerBound)
                    
                    text = validText
                }
            }
            
            self.text = text
        }
    }
}

@IBDesignable class UITextFieldCustom: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.insetBy(dx: self.dxInset, dy: 0.0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.insetBy(dx: self.dxInset, dy: 0.0)
    }
}
