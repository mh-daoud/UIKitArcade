//
//  HorizontalViewController.swift
//  UIKitArcade
//
//  Created by admin on 09/12/2023.
//


import UIKit

struct CarouselItem {
    let portraitImageUrl : String
    let landscapeImageUrl: String
    let logoTitleImageUrl: String
}

class SnapCarouselViewController : UIViewController {
    static let cardWidth: CGFloat = 80
    static let animatedCardWidth: CGFloat = 120
    static let cardHeight: CGFloat = 120
    
    let label = UILabel()
    let stackView = UIStackView()
    var items = [CarouselItem]()
    
    var carouselCards = [CarouselCardView]()
    var widthConstraints = [NSLayoutConstraint]()
    
    var activeIndex : Int = 0
    var prevIndex : Int {
        if activeIndex == 0 {
            return items.count - 1
        }
        return activeIndex - 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

extension SnapCarouselViewController {
    func setup() {
        items = [
            CarouselItem(portraitImageUrl: "https://shahid.mbc.net/mediaObject/Curation_2023/Clean-images/NOV/Asraralboyot_clean_poster_4/original/Asraralboyot_clean_poster_4.jpg?width=275&version=1&type=jpg",
                         landscapeImageUrl: "https://shahid.mbc.net/mediaObject/2023/AmrAhmed/Sep/Thump_Asrar_Al_Boyout/original/Thump_Asrar_Al_Boyout.jpg?width=297&version=1&type=jpg",
                         logoTitleImageUrl: "https://shahid.mbc.net/mediaObject/2023/Bedour3/Logo_Asrar_Al_BoyoutEN/original/Logo_Asrar_Al_BoyoutEN.png?height=80&width=&croppingPoint=mc&version=1&type=jpg"),
            CarouselItem(portraitImageUrl: "https://shahid.mbc.net/mediaObject/Curation_2023/Hero/DEC/almotawahesh_poster_clean/original/almotawahesh_poster_clean.jpg?width=290&version=1&type=jpg",
                         landscapeImageUrl: "https://shahid.mbc.net/mediaObject/2022/Amr/Thumps/AMRJUL/ThumpEN_Yabani0/original/ThumpEN_Yabani0.jpg?width=297&version=1&type=jpg",
                         logoTitleImageUrl: "https://shahid.mbc.net/mediaObject/2022/Amr/Thumps/AMRJUL/LogoEN_yabani0/original/LogoEN_yabani0.png?height=80&width=&croppingPoint=mc&version=1&type=webp"),
            CarouselItem(portraitImageUrl: "https://shahid.mbc.net/mediaObject/Curation_2023/Hero/DEC/Al_Khaen_2_Poster_clean/original/Al_Khaen_2_Poster_clean.jpg?width=290&version=1&type=jpg",
                         landscapeImageUrl: "https://shahid.mbc.net/mediaObject/2022/Amr/Thumps/untitled0/Thump_AlKhaen/original/Thump_AlKhaen.jpg?width=297&version=1&type=jpg",
                         logoTitleImageUrl: "https://shahid.mbc.net/mediaObject/2022/Amr/Thumps/untitled0/LogoEN_Alkhaen/original/LogoEN_Alkhaen.png?height=80&width=&croppingPoint=mc&version=1&type=jpg")
        ]
        
        items.forEach { item in
            carouselCards.append(CarouselCardView(portraitImage: item.portraitImageUrl, landscapeImage: item.landscapeImageUrl, logoTitleImage: item.logoTitleImageUrl))
        }
    }
    
    func style() {
        view.backgroundColor = .systemBackground
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        label.text = "Welcome"
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        
        carouselCards.forEach { cardView in
            cardView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func layout() {
        [label].forEach(view.addSubview)
        carouselCards.forEach(view.addSubview)
        
        //Label
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        widthConstraints = []
        for (index,_) in  carouselCards.enumerated() {
            addNextCard(index: index)
        }
        view.layoutIfNeeded()
        //setupAnimation()
    }
    
    private func addNextCard(index: Int) {
        let cardView = carouselCards[index]
        if index == 0 {
            cardView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true
        }
        else {
            let prevCard = carouselCards[index - 1]
            cardView.leadingAnchor.constraint(equalTo: prevCard.trailingAnchor, constant: 8).isActive = true
        }
        cardView.topAnchor.constraint(equalToSystemSpacingBelow: label.bottomAnchor, multiplier: 2).isActive = true
        let cardWidthConstraint = cardView.widthAnchor.constraint(equalToConstant: SnapCarouselViewController.cardWidth)
        cardWidthConstraint.isActive = true
        widthConstraints.append(cardWidthConstraint)
        cardView.heightAnchor.constraint(equalToConstant: SnapCarouselViewController.cardHeight).isActive = true
    }
    
    func setupAnimation() {
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) { [weak self] in
            guard let self else {return }
            widthConstraints[prevIndex].constant = SnapCarouselViewController.cardWidth
            widthConstraints[activeIndex].constant = SnapCarouselViewController.animatedCardWidth
            view.layoutIfNeeded()
        }
        animator.addCompletion { [weak self] _ in
            guard let self else {return}
            activeIndex += 1
            if activeIndex == carouselCards.count {
                activeIndex = 0
            }
            setupAnimation()
        }
        animator.startAnimation()
    }
}
