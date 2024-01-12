//
//  PortraitCard.swift
//  UIKitArcade
//
//  Created by admin on 31/12/2023.
//

import Foundation
import UIKit

class PortraitCard : UIView {
    
    var item: EditorialItem!
    
    var imageView = makeImageView()
    
    override init(frame: CGRect) {
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
    
    override var intrinsicContentSize: CGSize {
        return CommonSizes.shared.portraitShowCard
    }
}




extension PortraitCard {
    
    func setup() {
        if let posterUrl = ProductModelUtil.getPosterImage(item: item).getUrlWithDimension(size: CommonSizes.shared.portraitShowCard) {
            imageView.load(url: posterUrl)
        }
    }
    
    func style(){
        backgroundColor = ThemeColor.nearNero
        layer.cornerRadius = dimensionCalculation(8, 8)
        clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
