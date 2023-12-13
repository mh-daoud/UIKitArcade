//
//  StateButton.swift
//  UIKitArcade
//
//  Created by admin on 13/12/2023.
//

import Foundation
import UIKit

class StateButton : UIView {
    let button = UIButton()
    
    static let disabledBGColor = UIColor.systemGray
    static let enabledBGColor = UIColor.systemBlue
    
    var isSelected : Bool = false {
        didSet {
            button.tintColor = isSelected ? StateButton.enabledBGColor : StateButton.disabledBGColor
        }
    }
    
    init(title: String) {
        super.init(frame: .zero)
        button.setTitle(title, for: [])
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StateButton {
    
    func style(){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.tintColor = StateButton.disabledBGColor
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .preferredFont(forTextStyle: .caption1)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        
    }
    
    func layout(){
        addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
