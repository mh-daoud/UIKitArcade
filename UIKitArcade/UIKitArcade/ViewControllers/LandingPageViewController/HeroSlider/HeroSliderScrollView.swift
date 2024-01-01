//
//  HeroSliderTableView.swift
//  UIKitArcade
//
//  Created by admin on 31/12/2023.
//

import Foundation
import UIKit

class HeroSliderScrollView : UIScrollView {
    
    var slides: [EditorialItem]
    var containerView = UIView()
    var heroSlideViews = [HeroSlideView]()
    var heroSliderDelegate: HeroSliderScrollViewDelegate?
    override init(frame: CGRect) {
        slides = []
        super.init(frame: frame)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CommonSizes.shared.heroImageSize
    }
}


extension HeroSliderScrollView {
    
    func configure(items: [EditorialItem]) {
        self.slides = items
        setup()
        style()
        layout()
        
    }
    
    func setup() {
        heroSlideViews.removeAll()
        print("slides \(slides.count)")
        if slides.count > 1 {
            if let lastSlide = slides.last {
                addSlideView(lastSlide)
            }
        }
        slides.forEach(addSlideView(_:))
        if let firstSlide = slides.first {
            addSlideView(firstSlide)
        }
        print("total slides \(heroSlideViews.count)")
        heroSliderDelegate = HeroSliderScrollViewDelegate(threshold: getScreenSize().width * 0.25,
                                                          maxPages: heroSlideViews.count)
        delegate = heroSliderDelegate
        setContentOffset(CGPointMake(getScreenSize().width, 0), animated: false)
    }
    
    private func addSlideView(_ slideItem: EditorialItem) {
        let slide = HeroSlideView(item: slideItem)
        slide.translatesAutoresizingMaskIntoConstraints = false
        heroSlideViews.append(slide)
    }
    
    func style(){
        backgroundColor = ThemeColor.transparent
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = ThemeColor.transparent
    }
    
    func layout() {
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
}



//MARK: Snap Behivour
class HeroSliderScrollViewDelegate: NSObject, UIScrollViewDelegate {
    let threshold: CGFloat
    var page = 2
    let maxPages: Int
    var userDraging = false
    var oldXOffset: CGFloat = 0
    //var delegate: BannersCarouselSnapDelegate?
    
    var scrollSnapWidth : CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return CGFloat(page - 1) * screenWidth
    }
    
    init(threshold: CGFloat, maxPages: Int) {
        self.threshold = threshold
        self.maxPages = maxPages
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if(!userDraging) {
            oldXOffset = scrollView.contentOffset.x
        }
        userDraging = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        setContentOffset(scrollView:scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(userDraging) {
            let moveDelta = oldXOffset - scrollView.contentOffset.x;
            if (abs(moveDelta) > (threshold)) {
                oldXOffset = scrollView.contentOffset.x
                if ( moveDelta < 0 )
                {
                    page += 1
                }
                else
                {
                    page -= 1
                }
                scrollView.isScrollEnabled = false
            }
        }
    }
    
    func setContentOffset(scrollView: UIScrollView, animated: Bool = true) {
        userDraging = false
        scrollView.setContentOffset(CGPointMake(scrollSnapWidth, 0), animated: animated)
        scrollView.isScrollEnabled = true
        oldXOffset = scrollSnapWidth
        //self.delegate?.didSnapToPage(page: page)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if page ==  maxPages    {
            page = 2
            scrollView.isScrollEnabled = false
            setContentOffset(scrollView: scrollView, animated: false)
        }
        else if page == 1 {
            page = maxPages - 1
            scrollView.isScrollEnabled = false
            setContentOffset(scrollView: scrollView, animated: false)
        }
        userDraging = false
    }
}
