//
//  TopTenAndSeasonTag.swift
//  UIKitArcade
//
//  Created by admin on 31/12/2023.
//

import Foundation
import UIKit

class TopTenAndSeasonTag : UIView {
    
    private var item: EditorialItem?
    private var separatorView = UIView()
    private var label = makeLabel(text: "", fontType: .small, fontColor: ThemeColor.white)
    
    override init(frame: CGRect){
        super.init(frame: frame)
        style()
        layout()
    }
    
    func configure(item: EditorialItem) {
        self.item = item
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




extension TopTenAndSeasonTag {
    
    func setup() {
        
        label.isHidden = true
        isHidden = true
        if let item, let season = ProductModelUtil.getSeason(item: item), let tag = ProductModelUtil.getTag(item: season) {
            label.isHidden = false
            isHidden = false
            label.text = tag
        }
        
    }
    
    private func style(){
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = ThemeColor.jungleGreen
    }
    
    private func layout(){
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
