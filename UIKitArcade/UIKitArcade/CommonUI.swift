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
    static let snow = UIColor(hex: "#a3afc2")
    static let nero = UIColor(hex: "#272e3a")
    static let jungleGreen = UIColor(hex: "#00cc99")
    static let nearNero = UIColor(hex: "#181d25")
    static let transparent = UIColor.clear
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
    return label
}

func makeImageView() -> UIImageView{
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.contentMode = .scaleToFill
    return view
}
