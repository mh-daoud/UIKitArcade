//
//  HeroSliderScrollViewDelegate.swift
//  UIKitArcade
//
//  Created by admin on 03/01/2024.
//

import Foundation
import UIKit


protocol HeroSliderDelegate : AnyObject {
    func didSnapToSlide(slideIndex: Int)
}

//MARK: Snap Behivour
class HeroSliderScrollViewDelegate: NSObject {
    
    private let threshold: CGFloat
    private var slideNumber = 2
    private var maxPages: Int
    private var userDraging = false
    private var oldXOffset: CGFloat = 0
    weak var delegate: HeroSliderDelegate?
    
    private var slideIndex: Int {
        get {
            let index = slideNumber - 2
            if index < 0 {
                return maxPages - 2
            }
            return index
        }
    }
    
    private var scrollSnapWidth : CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return CGFloat(slideNumber - 1) * screenWidth
    }
    
    init(threshold: CGFloat, maxPages: Int) {
        self.threshold = threshold
        self.maxPages = maxPages
    }
    
    func snapToSlide(slideNumber: Int, scrollView: UIScrollView) {
        self.slideNumber = slideNumber + 1
        setContentOffset(scrollView: scrollView)
    }
    
    func snapToNextSlide(scrollView: UIScrollView) {
        // no need to add + 1 aleady we add in snapToSlide
        snapToSlide(slideNumber: slideNumber, scrollView: scrollView)
    }
    
    func setMaxPages(maxPages: Int) {
        self.maxPages = maxPages
    }
    
    private func setContentOffset(scrollView: UIScrollView, animated: Bool = true) {
        userDraging = false
        scrollView.isScrollEnabled = false
        scrollView.setContentOffset(CGPointMake(scrollSnapWidth, 0), animated: animated)
        scrollView.isScrollEnabled = true
        oldXOffset = scrollSnapWidth
        self.delegate?.didSnapToSlide(slideIndex: slideIndex)
    }
}

//MARK: ScrollViewDelegate
extension HeroSliderScrollViewDelegate : UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if(!userDraging) {
            oldXOffset = scrollView.contentOffset.x
        }
        userDraging = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() , execute: {
            self.setContentOffset(scrollView: scrollView)
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(userDraging) {
            let moveDelta = oldXOffset - scrollView.contentOffset.x;
            if (abs(moveDelta) > (threshold)) {
                oldXOffset = scrollView.contentOffset.x
                if ( moveDelta < 0 )
                {
                    slideNumber += 1
                }
                else
                {
                    slideNumber -= 1
                }
                scrollView.isScrollEnabled = false
            }
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if clampSlideNumber() {
            scrollView.isScrollEnabled = false
            setContentOffset(scrollView: scrollView, animated: false)
        }
        userDraging = false
    }
    
    private func clampSlideNumber() -> Bool {
        if slideNumber ==  maxPages    {
            slideNumber = 2
            return true
        }
        else if slideNumber == 1 {
            slideNumber = maxPages - 1
            return true
        }
        return false
    }
    
}

