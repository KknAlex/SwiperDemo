//
//  Extensions.swift
//  TipsterDemo
//
//  Created by Alex on 19.01.2022.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(hex:Int) {
        self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
}

extension UIViewController {
    static func fromStoryboard() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let name = String(describing: self)
        let vc = storyboard.instantiateViewController(withIdentifier: name)
        return vc
    }
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func round(radius: CGFloat, borderWidth: CGFloat? = nil, borderColor: CGColor? = nil, clipsToBounds: Bool = false) {
        
        layer.cornerRadius = radius
        if let borderWidth = borderWidth {
            layer.borderWidth = borderWidth
        }
        if let borderColor = borderColor {
            layer.borderColor = borderColor
        }
        
        self.clipsToBounds = clipsToBounds
    }
    
    func round(radius: CGFloat, corners: UIRectCorner = [.topLeft , .bottomLeft, .bottomRight], borderWidth: CGFloat? = nil, borderColor: CGColor? = nil) {
        
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
        
        if let borderWidth = borderWidth, let borderColor = borderColor {
            let borderLayer = CAShapeLayer()
            borderLayer.frame = bounds
            borderLayer.lineWidth = borderWidth
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = borderColor
            borderLayer.path = maskPath.cgPath
            layer.addSublayer(borderLayer)
        }
    }
    
    func addShadow(shadowColor: CGColor = UIColor(hex: 0x00333B).withAlphaComponent(0.1).cgColor, shadowOffset: CGSize = CGSize(width: 0, height: 0), shadowOpacity: Float = 1, shadowRadius: CGFloat = 7.0, cornerRadius: CGFloat = 1) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    func round(radius: CGFloat, shadowColor: CGColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = radius

        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
