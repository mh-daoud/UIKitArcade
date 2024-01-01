//
//  BasicButton.swift
//  UIKitArcade
//
//  Created by admin on 31/12/2023.
//

import Foundation
import UIKit

class BasicButton : UIButton {
    
    let type: CustomButtonType
    
    init(type: CustomButtonType){
        self.type = type
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        style()
        layout()
    }
    
}




extension BasicButton {
    
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        configuration = UIButton.Configuration.plain()
        configuration?.contentInsets = NSDirectionalEdgeInsets(top: dimensionCalculation(4, 4), leading: dimensionCalculation(14, 14), bottom: dimensionCalculation(4, 4), trailing: dimensionCalculation(14, 14))
        configuration?.imagePlacement = .leading
        configuration?.imagePadding = CGFloat(dimensionCalculation(8, 8))
        setTitleColor(ThemeColor.white, for: [])
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard  layer.sublayers == nil || layer.sublayers!.filter({$0 is CAGradientLayer}).count == 0 else {
            return
        }
        if (type.rawValue | CustomButtonType.gradientFilled.rawValue) ==  CustomButtonType.gradientFilled.rawValue || (type.rawValue | CustomButtonType.capsuleGradientFilled.rawValue) == CustomButtonType.capsuleGradientFilled.rawValue {
            let _ = applyGradient(colours: [ThemeColor.jungleGreen, ThemeColor.darkBlue], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0))
        }
        if (type.rawValue | CustomButtonType.gradientBorder.rawValue) ==  CustomButtonType.gradientBorder.rawValue {
            let _ = applyGradientBorder(colours: [ThemeColor.jungleGreen, ThemeColor.darkBlue], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0))
        }
        if (type.rawValue | CustomButtonType.capsuleGradientBorder.rawValue) == CustomButtonType.capsuleGradientBorder.rawValue || (type.rawValue | CustomButtonType.capsuleGradientFilled.rawValue) == CustomButtonType.capsuleGradientFilled.rawValue {
            layer.cornerRadius = self.frame.height / 2
            if (type.rawValue | CustomButtonType.capsuleGradientBorder.rawValue) == CustomButtonType.capsuleGradientBorder.rawValue {
                let _ = applyGradientBorder(colours: [ThemeColor.jungleGreen, ThemeColor.darkBlue], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0), withRadius: layer.cornerRadius)
            }
        }
    }
    
    func layout() {
        
    }
}

enum CustomButtonType : Int {
    case gradientFilled = 1
    case gradientBorder = 2
    case capsuleGradientFilled = 4
    case capsuleGradientBorder = 8
}


extension BasicButton {
    func setPlayIcon(withColor tintColor: UIColor = ThemeColor.white) {
        setImage(UIImage(systemName: "play.fill")!.withRenderingMode(.alwaysOriginal).withTintColor(tintColor), for: [])
    }
    
    func setAddToFavIcon(withColor tintColor: UIColor = ThemeColor.white) {
        setImage(UIImage(systemName: "plus")!.withRenderingMode(.alwaysOriginal).withTintColor(tintColor), for: [])
    }
}
