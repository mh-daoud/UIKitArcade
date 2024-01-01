//
//  UIView+Utils.swift
//  UIKitArcade
//
//  Created by admin on 31/12/2023.
//

import Foundation
import UIKit

extension UIView {
    func applyGradient(colours: [UIColor], startPoint: CGPoint, endPoint: CGPoint) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    func applyGradientBorder(colours: [UIColor], startPoint: CGPoint, endPoint: CGPoint, withRadius: CGFloat? = nil) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame =  self.bounds
        gradient.colors = colours.map { $0.cgColor }
        
        let shape = CAShapeLayer()
        shape.lineWidth = 4
        if let withRadius {
            shape.path =  UIBezierPath(roundedRect: self.bounds, cornerRadius: withRadius).cgPath
        }
        else {
            shape.path =  UIBezierPath(rect: self.bounds).cgPath
        }
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        self.layer.addSublayer(gradient)
        return gradient
    }
}

