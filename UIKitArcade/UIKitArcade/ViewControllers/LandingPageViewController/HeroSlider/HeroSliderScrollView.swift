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
    private var heroSliderScrollViewDelegate: HeroSliderScrollViewDelegate
    
    override init(frame: CGRect) {
        slides = []
        heroSliderScrollViewDelegate = HeroSliderScrollViewDelegate(threshold: getScreenSize().width * 0.25,
                                                                    maxPages: heroSlideViews.count)
        super.init(frame: frame)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        bounces = false
        
        style()
        layout()
        delegate = heroSliderScrollViewDelegate
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
    }
    
    private func setup(_ heroSliderDelegate: HeroSliderDelegate? = nil) {
        if slides.count > 1 {
            if let lastSlide = slides.last {
                addSlideView(index: 0, slide: lastSlide)
            }
        }
        for (index,slide) in slides.enumerated() {
            addSlideView(index: index + 1, slide: slide)
        }
        if let firstSlide = slides.first {
            addSlideView(index: slides.count + 1, slide:firstSlide, isLastSlide: true)
        }
        
        heroSliderScrollViewDelegate.setMaxPages(maxPages : heroSlideViews.count)
        heroSliderScrollViewDelegate.delegate = heroSliderDelegate
    }
    
    private func addSlideView(index: Int, slide: EditorialItem, isLastSlide: Bool = false) {
        let slideView : HeroSlideView
        if index < heroSlideViews.count  {
            slideView = heroSlideViews[index]
        }
        else {
            slideView = HeroSlideView()
            slideView.translatesAutoresizingMaskIntoConstraints = false
            heroSlideViews.append(slideView)
            containerView.addSubview(slideView)
            layoutSlide(index: index, isLastSlide: isLastSlide)
        }
        slideView.configure(item: slide)
    }
    
    private func layoutSlide(index: Int, isLastSlide: Bool) {
        let slideView = heroSlideViews[index]
        let prevSlideView = index > 0 ? heroSlideViews[index - 1] : nil
        NSLayoutConstraint.activate([
            slideView.topAnchor.constraint(equalTo: topAnchor),
            slideView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        if index == 0 {
            NSLayoutConstraint.activate([
                slideView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
            ])
        }
        else if let prevSlideView {
            NSLayoutConstraint.activate([
                slideView.leadingAnchor.constraint(equalTo: prevSlideView.trailingAnchor)
            ])
        }
        
        if isLastSlide {
            NSLayoutConstraint.activate([
                slideView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])
        }
    }
    
    private func style(){
        backgroundColor = ThemeColor.transparent
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = ThemeColor.transparent
    }
    
    private func layout() {
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func snapToSlide(slideNumber: Int, animated: Bool = true) {
        heroSliderScrollViewDelegate.snapToSlide(slideNumber: slideNumber, scrollView: self, animated: animated)
    }
    
    func snapToNextSlide() {
        heroSliderScrollViewDelegate.snapToNextSlide( scrollView: self)
    }
}
