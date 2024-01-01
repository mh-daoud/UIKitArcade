//
//  HeroSlideView.swift
//  UIKitArcade
//
//  Created by admin on 31/12/2023.
//

import Foundation

import UIKit

class HeroSlideView : UIView {
    
    var item: ProductModelSharedDetails!
    var posterImageView = makeImageView()
    var logoTitleImageView = makeImageView()
    
    var stackView = makeStackView(axies: .horizontal)
    var watchNowButton = makeButton()
    var addToMyListButton = makeButton(withType: .capsuleGradientBorder)
    var bottomGradientBG = UIView()
    var seasonAndGenraView: SeasonAndGenraView!
    var topTenAndSeasonTag: TopTenAndSeasonTag?
    
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
    
    override var intrinsicContentSize: CGSize {
        return CommonSizes.shared.heroImageSize
    }
}

extension HeroSlideView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if bottomGradientBG.layer.sublayers == nil {
            let _ = bottomGradientBG.applyGradient(colours: [ThemeColor.nero!,ThemeColor.transparent.withAlphaComponent(0)], startPoint: CGPoint(x: 0, y: 1), endPoint: CGPoint(x: 0, y: 0))
        }
       
    }
}

extension HeroSlideView {
    
    func setup() {
        if let heroUrl = ProductModelUtil.getHeroImage(item: item).getUrlWithDimension(size: CommonSizes.shared.heroImageSize) {
            posterImageView.load(url: heroUrl)
        }
        
        if let logoTitleUrl = ProductModelUtil.getLogoTitle(item: item).getUrlWithDimension(width: CommonSizes.shared.logoTitle.width, height: 0, withType: .Webp) {
            logoTitleImageView.load(url: logoTitleUrl)
            logoTitleImageView.contentMode = .scaleAspectFit
        }
        seasonAndGenraView = SeasonAndGenraView(item: item)
        if let editorialItem = item as? EditorialItem {
            topTenAndSeasonTag = TopTenAndSeasonTag(item: editorialItem)
        }
    }
    
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        
        watchNowButton.setTitle("Watch now", for: .normal)
        watchNowButton.setPlayIcon()
        
        addToMyListButton.setTitle("Add to List", for: .normal)
        addToMyListButton.setAddToFavIcon()
        
        posterImageView.layer.zPosition = 5
        
        bottomGradientBG.translatesAutoresizingMaskIntoConstraints = false
        bottomGradientBG.backgroundColor = .clear
        bottomGradientBG.layer.zPosition = 7
        
        seasonAndGenraView.translatesAutoresizingMaskIntoConstraints = false
        
        topTenAndSeasonTag?.translatesAutoresizingMaskIntoConstraints = false
        topTenAndSeasonTag?.layer.zPosition = 10
    }
    
    func layout(){
        [posterImageView, bottomGradientBG, logoTitleImageView, seasonAndGenraView, stackView].forEach(addSubview(_:))
        
        stackView.addArrangedSubview(addToMyListButton)
        stackView.addArrangedSubview(watchNowButton)

        //main poster image
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        //logoTitle Image
        NSLayoutConstraint.activate([
            logoTitleImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoTitleImageView.widthAnchor.constraint(lessThanOrEqualToConstant: dimensionCalculation(200, 180)),
            logoTitleImageView.heightAnchor.constraint(lessThanOrEqualToConstant:  dimensionCalculation(96, 88)),
        ])
        
        //buttons
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
        ])
        
        //seasonAndGenra
        NSLayoutConstraint.activate([
            seasonAndGenraView.topAnchor.constraint(equalToSystemSpacingBelow: logoTitleImageView.bottomAnchor, multiplier: 1),
            seasonAndGenraView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        if let topTenAndSeasonTag, !topTenAndSeasonTag.isHidden {
            addSubview(topTenAndSeasonTag)
           
            //topten and season tag
            NSLayoutConstraint.activate([
                topTenAndSeasonTag.topAnchor.constraint(equalToSystemSpacingBelow: seasonAndGenraView.bottomAnchor, multiplier: 2),
                stackView.topAnchor.constraint(equalToSystemSpacingBelow: topTenAndSeasonTag.bottomAnchor, multiplier: 2),
                topTenAndSeasonTag.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        }
        else {
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalToSystemSpacingBelow: seasonAndGenraView.bottomAnchor, multiplier: 2)
            ])
        }
        
       
        
        //bottomGradientBG
        NSLayoutConstraint.activate([
            bottomGradientBG.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomGradientBG.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: bottomGradientBG.trailingAnchor),
            bottomGradientBG.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])
    }
}
