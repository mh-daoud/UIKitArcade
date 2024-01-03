//
//  CommonUI.swift
//  UIKitArcade
//
//  Created by admin on 28/12/2023.
//

import Foundation
import UIKit


enum FontType {
    case extraLarge
    case large
    case medium
    case small
}


struct ThemeColor {
    static let white = UIColor.white
    static let snow = UIColor(hex: "#a3afc2")!
    static let nero = UIColor(hex: "#272e3a")!
    static let jungleGreen = UIColor(hex: "#00cc99")!
    static let darkBlue = UIColor(hex: "#0099ff")!
    static let nearNero = UIColor(hex: "#181d25")!
    static let transparent = UIColor.clear
    static let gray1 = UIColor(hex: "#cccccc")!
}

func makeLabel(text: String, fontType: FontType = .medium,fontColor: UIColor? = ThemeColor.snow) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    switch fontType {
        case .extraLarge :
            label.font = .preferredFont(forTextStyle: .title1)
        case .large :
            label.font = .preferredFont(forTextStyle: .title2)
        case .medium :
            label.font = .preferredFont(forTextStyle: .callout)
        case .small :
            label.font = .preferredFont(forTextStyle: .caption2)
    }
    if let fontColor {
        label.textColor = fontColor
    }
    label.layer.zPosition = 10
    return label
}

func makeImageView() -> UIImageView{
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleToFill
    view.layer.zPosition = 10
    return view
}

func makeButton(withType: CustomButtonType = .capsuleGradientFilled) -> BasicButton {
    let view = BasicButton(type: withType)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.zPosition = 10
    return view
}


func makeStackView(axies: NSLayoutConstraint.Axis = .horizontal) -> UIStackView {
    let view  = UIStackView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.axis = axies
    view.alignment = .center
    view.spacing = dimensionCalculation(8, 8)
    view.layer.zPosition = 10
    return view
}
