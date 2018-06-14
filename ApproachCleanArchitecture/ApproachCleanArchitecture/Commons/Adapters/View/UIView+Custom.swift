//
//  UIView+Custom.swift
//  ApproachCleanArchitecture
//
//  Created by Rone Loza on 6/13/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import UIKit

protocol ViewBorderable {
    
    var borderRadius: CGFloat { set get }
    var borderRadiusPercent: CGFloat { set get}
    var borderColor: UIColor { set get }
    var borderWidth: CGFloat { set get }
}

protocol ViewGradientable {
    
    var direction: Int { set get}
    var startColor: UIColor { set get }
    var endColor: UIColor { set get }
    var middleColor: UIColor { set get }
    var startPoint: CGPoint { set get }
    var endPoint: CGPoint { set get }
}

enum GradientableOptionsDirection: Int {
    
    case top = 0
    case bottom
    case custom // startPoint, endPoint (0.0 ~ 1.0)
    
    init?(intValue: Int) {
        
        switch intValue {
        case 0:
            self = .top
            
        case 1:
            self = .bottom
            
        case 2:
            self = .custom
            
        default:
            return nil
        }
    }
}

class ViewGradientableOptions {
    
    var gradientLayer: CAGradientLayer
    var direction: GradientableOptionsDirection
    var startColor: UIColor
    var middleColor: UIColor?
    var endColor: UIColor
    var startPoint: CGPoint?
    var endPoint: CGPoint?
    
    
    init(gradientLayer: CAGradientLayer,
         direction: GradientableOptionsDirection,
         startColor: UIColor,
         middleColor: UIColor?,
         endColor: UIColor,
         startPoint: CGPoint?,
         endPoint: CGPoint?
        ) {
        
        self.gradientLayer = gradientLayer
        self.direction = direction
        self.startColor = startColor
        self.middleColor = middleColor
        self.endColor = endColor
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
    func apply(layer: CAGradientLayer?) {
        
        if let middleColor = self.middleColor {
            
            layer?.colors = [self.startColor.cgColor, middleColor.cgColor,
                             middleColor.cgColor, self.endColor.cgColor]
        }
        else {
            
            layer?.colors = [self.startColor.cgColor, self.endColor.cgColor]
        }
        
        applyDirection(layer: layer)
    }
    
    // MARK: - Private
    private func applyDirection(layer: CAGradientLayer?) {
        
        switch direction {
        case .top:
            layer?.startPoint = CGPoint(x: 0.5, y: 1.0)
            layer?.endPoint = CGPoint(x: 0.5, y: 0.0)
            layer?.locations = self.middleColor != nil ? [0.0, 0.2, 0.8, 1.0] : [0.5 , 1.0]
            
        case .bottom:
            layer?.startPoint = CGPoint(x: 0.5, y: 0.0)
            layer?.endPoint = CGPoint(x: 0.5, y: 1.0)
            layer?.locations = self.middleColor != nil ? [0.0, 0.2, 0.8, 1.0] : [0.5 , 1.0]
            
        case .custom:
            
            if let start = self.startPoint,
                let end = self.endPoint {
                
                layer?.startPoint = start
                layer?.endPoint = end
                
                layer?.locations = self.middleColor != nil ? [0.0, 0.2, 0.8, 1.0] : [start.x as NSNumber , end.y as NSNumber]
            }
        }
    }
    
}

extension UIView: ViewBorderable {

    @IBInspectable var borderColor: UIColor {

        get {

            return UIColor.init(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {

            self.layer.borderColor = newValue.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat {

        get {

            return self.layer.borderWidth
        }
        set {

            self.layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderRadius: CGFloat {

        get {

            return self.layer.cornerRadius
        }
        set {

            self.layer.cornerRadius = newValue
        }
    }

    @IBInspectable var borderRadiusPercent: CGFloat {

        get {

            return 0.0
        }
        set {

            if 0.0 ... 1.0 ~= newValue {

                self.layer.cornerRadius = self.bounds.size.width * newValue
            }
        }
    }
}

extension UIView: ViewGradientable {

    private struct AssociatedKeys {
        static var configuration = "configuration"
    }

    internal var gradientLayer: CAGradientLayer?  {

        return self.configuration?.gradientLayer
    }

    private var configuration: ViewGradientableOptions? {

        get { return objc_getAssociatedObject(self, &AssociatedKeys.configuration) as? ViewGradientableOptions }
        set { objc_setAssociatedObject(self, &AssociatedKeys.configuration, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    @IBInspectable var direction: Int {

        get {

            self.initGradientable()
            return (self.configuration?.direction.rawValue ?? 0)
        }
        set {

            self.initGradientable()
            self.configuration?.direction = GradientableOptionsDirection.init(rawValue: newValue)!
            self.performGradient()
        }
    }

    @IBInspectable var startColor: UIColor {

        get {

            self.initGradientable()
            return self.configuration?.startColor ?? UIColor.clear
        }set {

            self.initGradientable()
            self.configuration?.startColor = newValue
            self.performGradient()
        }
    }

    @IBInspectable var endColor: UIColor {

        get {

            self.initGradientable()
            return self.configuration?.endColor ?? UIColor.clear
        }set {

            self.initGradientable()
            self.configuration?.endColor = newValue
            self.performGradient()
        }
    }

    @IBInspectable var middleColor: UIColor {

        get {

            self.initGradientable()
            return self.configuration?.middleColor ?? UIColor.clear
        }set {

            self.initGradientable()
            self.configuration?.middleColor = newValue
            self.performGradient()
        }
    }

    @IBInspectable var startPoint: CGPoint {

        get {

            self.initGradientable()
            return self.configuration?.startPoint ?? CGPoint.zero
        }set {

            self.initGradientable()
            self.configuration?.startPoint = newValue
            self.performGradient()
        }
    }

    @IBInspectable var endPoint: CGPoint {

        get {

            self.initGradientable()
            return self.configuration?.endPoint ?? CGPoint.zero
        }set {

            self.initGradientable()
            self.configuration?.endPoint = newValue
            self.performGradient()
        }
    }

    private func initGradientable() {

        if configuration == nil {
            setupGradientable()
        }
    }

    private func performGradient() {

        configuration?.apply(layer: configuration?.gradientLayer)
    }

    // MARK: - Private
    private func setupGradientable() {

        self.clipsToBounds = true

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)

        configuration = ViewGradientableOptions.init(gradientLayer: gradientLayer, direction: GradientableOptionsDirection.top, startColor: UIColor.clear, middleColor: nil, endColor: UIColor.clear, startPoint: CGPoint.zero, endPoint: CGPoint.zero)

        //        let originalSelector = #selector(layoutSubviews)
        //        let swizzledSelector = #selector(swizzled_layoutSubviews)
        //
        //        guard let originalMethod = class_getInstanceMethod(UIView.self, originalSelector),
        //            let swizzledMethod = class_getInstanceMethod(UIView.self, swizzledSelector) else {
        //                return
        //        }
        //        method_exchangeImplementations(originalMethod, swizzledMethod)
    }

    //    @objc func swizzled_layoutSubviews() {
    //
    //        swizzled_layoutSubviews()
    //        configuration?.gradientLayer.frame = self.bounds
    //    }

}

@IBDesignable class GradientCustomView : UIView {
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.gradientLayer?.frame = self.bounds
    }
}


@IBDesignable class CornerView : UIView {
    
}
