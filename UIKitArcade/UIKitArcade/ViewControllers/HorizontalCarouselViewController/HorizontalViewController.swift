//
//  HorizontalViewController.swift
//  UIKitArcade
//
//  Created by admin on 09/12/2023.
//


import UIKit


class HorizontalCarouselViewController : UIViewController {
   
    let label = UILabel()
    var horizontalCarousel = HorizontalCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension HorizontalCarouselViewController {
    func style() {
        view.backgroundColor = .systemBackground
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        label.text = "Welcome"
        
        horizontalCarousel.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    func layout() {
        [label, horizontalCarousel].forEach(view.addSubview)
        
        //Label
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        //Carousel
        NSLayoutConstraint.activate([
            horizontalCarousel.topAnchor.constraint(equalToSystemSpacingBelow: label.bottomAnchor, multiplier: 1),
            horizontalCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalCarousel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
