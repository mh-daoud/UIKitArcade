//
//  Helpers.swift
//  UIKitArcade
//
//  Created by admin on 30/12/2023.
//

import Foundation
import UIKit

func designBaseSize() -> CGSize {
    isTablet() ? CGSize(width: 1024, height: 842) : CGSize(width: 320, height: 640)
}

func isTablet() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}

func dimensionCalculation(_ iPadDimension: CGFloat, _ iPhoneDimension: CGFloat) -> CGFloat {
    let screenSize = UIScreen.main.bounds
    if isTablet() {
        return floor(Double((iPadDimension * screenSize.width) / designBaseSize().width))
    }
    else {
        return floor(Double((iPhoneDimension * screenSize.width) / designBaseSize().width))
    }
}

func getScreenSize() -> CGSize {
    return UIScreen.main.bounds.size
}

struct CommonSizes {
    static let shared = CommonSizes()
    
    var portraitShowCard : CGSize {
        return CGSize(width: dimensionCalculation(130, 96), height: dimensionCalculation(192, 142))
    }
    
    var logoTitle : CGSize {
        return CGSize(width: dimensionCalculation(216, 246), height: dimensionCalculation(96, 88))
    }
    
    var heroImageSize : CGSize {
        return CGSize(width: getScreenSize().width, height: dimensionCalculation(320, 474))
    }
    
    private init(){}
}
