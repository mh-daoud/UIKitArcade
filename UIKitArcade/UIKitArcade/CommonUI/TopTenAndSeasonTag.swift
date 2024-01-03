//
//  TopTenAndSeasonTag.swift
//  UIKitArcade
//
//  Created by admin on 31/12/2023.
//

import Foundation
import UIKit

class TopTenAndSeasonTag : UIView {
    
    var item: EditorialItem
    var separatorView = UIView()
    var label = makeLabel(text: "", fontType: .small, fontColor: ThemeColor.white)
    
    init(item: EditorialItem) {
        self.item = item
        super.init(frame: .zero)
        setup()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




extension TopTenAndSeasonTag {
    func setup() {
        label.isHidden = true
        isHidden = true
        if let season = ProductModelUtil.getSeason(item: item), let tag = ProductModelUtil.getTag(item: season) {
            label.isHidden = false
            isHidden = false
            label.text = tag
        }
    }
    
    func style(){        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = ThemeColor.jungleGreen
    }
    
    func layout(){
        [separatorView, label].forEach(addSubview(_:))
        NSLayoutConstraint.activate([
            separatorView.widthAnchor.constraint(equalToConstant: dimensionCalculation(4, 4)),
            separatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            separatorView.heightAnchor.constraint(equalTo: label.heightAnchor, multiplier: 1.2),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: separatorView.trailingAnchor, multiplier: 0.5),
            label.centerYAnchor.constraint(equalTo: separatorView.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
