//
//  GreenCricle.swift
//  UIKitArcade
//
//  Created by admin on 31/12/2023.
//

import Foundation
import UIKit

class GreenCircle : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 6, height: 6)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if layer.cornerRadius == 0 {
            backgroundColor = ThemeColor.jungleGreen
            clipsToBounds = true
            layer.cornerRadius = bounds.height / 2
        }
    }
}
