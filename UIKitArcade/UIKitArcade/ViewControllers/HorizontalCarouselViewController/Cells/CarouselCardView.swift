//
//  CarouselCardView.swift
//  UIKitArcade
//
//  Created by admin on 10/12/2023.
//

import Foundation
import UIKit
class CarouselCardView : UIView {
    
    
    let imageView = UIImageView()
    let portraitImageUrl: URL?
    let landscapeImageUrl: URL?
    let logoTitleImageUrl: URL?
    
    init(portraitImage: String, landscapeImage: String, logoTitleImage: String) {
        portraitImageUrl = URL(string: portraitImage)
        landscapeImageUrl = URL(string: landscapeImage)
        logoTitleImageUrl = URL(string: logoTitleImage)
        super.init(frame: .zero)
        setup()
        style()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 80, height: 160)
    }
}


extension CarouselCardView {
    
    func setup(){
        backgroundColor = .systemOrange
        layer.cornerRadius = 8
        clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        if let portraitImageUrl {
            imageView.load(url: portraitImageUrl)
        }
        
    }
    
    func style() {
        addSubview(imageView)
        //ImageView
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
}
