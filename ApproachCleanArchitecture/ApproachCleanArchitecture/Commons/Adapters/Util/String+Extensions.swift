//
//  String+Extensions.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/13/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

protocol StringInputable {
    
    func stringRemoveCharartersEmoji() -> String
    func stringOnlyDigits() -> String
    func stringFormatDate(separator: String, atIndex: Int) -> String
    func isValidEmail() -> Bool
}

//protocol StringCreditCard {
//
//    var visaRegex : String { get }
//    var masterCardRegex: String { get }
//    var amexRegex : String { get }
//
//    func cardNumberBrand(numberString: String?) -> PayCardBrand
//}
//
//extension StringCreditCard {
//
//    var visaRegex: String {
//        get {
//            return "^4[0-9]{6,}$"
//        }
//    }
//    var masterCardRegex: String {
//        get {
//            return "^5[1-5][0-9]{5,}|222[1-9][0-9]{3,}|22[3-9][0-9]{4,}|2[3-6][0-9]{5,}|27[01][0-9]{4,}|2720[0-9]{3,}$"
//        }
//    }
//
//    var amexRegex: String {
//        get {
//            return "^3[47][0-9]{5,}$"
//        }
//    }
//}

//extension String: StringCreditCard {
//    
//    private func matches(for regex: String, in text: String) -> [String] {
//        
//        if let regularExpression = try? NSRegularExpression.init(pattern: regex, options: .caseInsensitive) {
//            
//            let results = regularExpression.matches(in: text, range: NSRange(text.startIndex..., in: text))
//            return results.compactMap({ (result: NSTextCheckingResult) -> String in
//                
//                if let range = Range.init(result.range, in: text) {
//                    
//                    return String.init(text[range])
//                }
//                else {
//                    
//                    return ""
//                }
//            })
//        }
//        else {
//            
//            return []
//        }
//    }
//    
//    func cardNumberBrand(numberString: String?) -> PayCardBrand {
//        
//        if (self.matches(for: self.amexRegex, in: numberString!).count > 0){
//            
//            return .AMEX
//        }
//        else if (self.matches(for: visaRegex, in: numberString!).count > 0){
//            
//            return .VISA
//        }
//        else if (self.matches(for: masterCardRegex, in: numberString!).count > 0){
//            
//            return .MASTERCARD
//        }
//        
//        return .NONE
//    }
//}

extension String: StringInputable {
    
    func isValidEmail()-> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    
    func stringRemoveCharartersEmoji() -> String {
        
        var set: CharacterSet = CharacterSet.alphanumerics
        set.formUnion(CharacterSet.punctuationCharacters)
        set.formUnion(CharacterSet.controlCharacters)
        set.formUnion(CharacterSet.whitespaces)
        set.formUnion(CharacterSet.init(charactersIn: "+-/*()!¡¿?#$%&_<>={}[]@"))
        
        let characters = self.components(separatedBy: set.inverted)
        
        let newText = characters.joined(separator: "")
        
        return newText
    }
    
    func stringOnlyDigits() -> String {
        
        let set: CharacterSet = CharacterSet.decimalDigits
        
        return self.components(separatedBy: set.inverted).joined(separator: "")
    }
    
    func stringFormatDate(separator: String, atIndex: Int) -> String {
        
        var text = self
        let set: CharacterSet = CharacterSet.init(charactersIn: separator)
        let characters = text.components(separatedBy: set.inverted).joined(separator: "")
        
        if characters.count == separator.count {
            
            let validText = text.stringOnlyDigits()
            
            if validText.count > 0 &&
                validText.count != atIndex,
                let range = text.range(of: separator) {
                
                text = text.stringOnlyDigits()
                text.insert(contentsOf: separator, at: range.lowerBound)
            }
            else if validText.count == atIndex {
                
                text = validText
            }
            else {
                
                text = text.stringOnlyDigits()
            }
        }
        else if characters.count > separator.count {
            
            if let range = text.range(of: separator) {
                
                text = text.stringOnlyDigits()
                text.insert(contentsOf: separator, at: range.lowerBound)
            }
            else {
                
                text = text.stringOnlyDigits()
            }
        }
        else {
            
            text = text.stringOnlyDigits()
            
            if text.count >= (atIndex + 1) {
                
                text = String(text.prefix(atIndex) + "\(separator)" + text.suffix((text.count - atIndex)))
            }
        }
        
        return text
    }
}
