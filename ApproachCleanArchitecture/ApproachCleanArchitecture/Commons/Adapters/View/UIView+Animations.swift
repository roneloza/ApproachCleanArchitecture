//
//  UIView+Animations.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/13/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import UIKit

protocol UIViewCustomAnimate {
    
    static func animateCurveEaseIn(duration: TimeInterval, delay: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?)
    static func animateCurveEaseInOut(duration: TimeInterval, delay: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?)
    static func animateBeginFromCurrentState(duration: TimeInterval, delay: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?)
}

protocol UIViewCustomAnimateNative: UIViewCustomAnimate { }

extension UIViewCustomAnimateNative {
    
    static func animateCurveEaseIn(duration: TimeInterval, delay: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: animations, completion: completion)
    }
    
    static func animateCurveEaseInOut(duration: TimeInterval, delay: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseInOut, animations: animations, completion: completion)
    }
    
    static func animateBeginFromCurrentState(duration: TimeInterval, delay: TimeInterval, animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        
        
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.beginFromCurrentState, animations: animations, completion: completion)
    }
}

extension UIView: UIViewCustomAnimateNative {
    
}
