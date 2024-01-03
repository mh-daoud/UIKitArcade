//
//  HeroSliderTableView.swift
//  UIKitArcade
//
//  Created by admin on 31/12/2023.
//

import Foundation
import UIKit

class HeroSliderScrollView : UIScrollView {
   
    private var slides: [EditorialItem]
    private var containerView = UIView()
    private var heroSlideViews = [HeroSlideView]()
    private var heroSliderScrollViewDelegate: HeroSliderScrollViewDelegate?

    override init(frame: CGRect) {
        slides = []
        super.init(frame: frame)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        bounces = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CommonSizes.shared.heroImageSize
    }
}


extension HeroSliderScrollView {
    
    func configure(items: [EditorialItem], delegate: HeroSliderDelegate? = nil) {
        self.slides = items
        setup(delegate)
        style()
        layout()
        
    }
    
    private func setup(_ heroSliderDelegate: HeroSliderDelegate? = nil) {
        heroSlideViews.removeAll()
        
        if slides.count > 1 {
            if let lastSlide = slides.last {
                addSlideView(lastSlide)
            }
        }
        
        slides.forEach(addSlideView(_:))
        if let firstSlide = slides.first {
            addSlideView(firstSlide)
        }
        
        heroSliderScrollViewDelegate = HeroSliderScrollViewDelegate(threshold: getScreenSize().width * 0.25,
                                                          maxPages: heroSlideViews.count)
        
        delegate = heroSliderScrollViewDelegate
        heroSliderScrollViewDelegate?.delegate = heroSliderDelegate
        setContentOffset(CGPointMake(getScreenSize().width, 0), animated: false)
    }
    
    private func addSlideView(_ slideItem: EditorialItem) {
        let slide = HeroSlideView(item: slideItem)
        slide.translatesAutoresizingMaskIntoConstraints = false
        heroSlideViews.append(slide)
    }
    
    private func style(){
        backgroundColor = ThemeColor.transparent
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = ThemeColor.transparent
    }
    
    private func layout() {
        addSubview(containerView)
        heroSlideViews.forEach(containerView.addSubview(_:))
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        for (index,slideView) in heroSlideViews.enumerated() {
            NSLayoutConstraint.activate([
                slideView.topAnchor.constraint(equalTo: topAnchor),
                slideView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            if index == 0 {
                NSLayoutConstraint.activate([
                    slideView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
                ])
            }
            else {
                let prevSlideView = heroSlideViews[index - 1]
                NSLayoutConstraint.activate([
                    slideView.leadingAnchor.constraint(equalTo: prevSlideView.trailingAnchor)
                ])
            }
            if index == heroSlideViews.count - 1 {
                NSLayoutConstraint.activate([
                    slideView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
                ])
            }
        }
    }
    
    func snapToSlide(slideNumber: Int) {
        heroSliderScrollViewDelegate?.snapToSlide(slideNumber: slideNumber, scrollView: self)
    }
    
    func snapToNextSlide() {
        heroSliderScrollViewDelegate?.snapToNextSlide( scrollView: self)
    }
}
