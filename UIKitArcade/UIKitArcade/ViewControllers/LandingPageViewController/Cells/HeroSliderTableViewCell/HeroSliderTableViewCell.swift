//
//  HeroSliderTableViewCell.swift
//  UIKitArcade
//
//  Created by admin on 31/12/2023.
//

import Foundation
import UIKit

import UIKit

class HeroSliderTableViewCell : UITableViewCell {
    
    static let reusableId = "hero_slider_table_view_cell"
    
    private var items: [EditorialItem]? = nil
    private var heroSliderScrollView : HeroSliderScrollView!
    private var sliderIndicator: SliderIndicator!
    
    private var timer: Timer?
    private let autoScrollTimeInterval: Int
    
    private var container: AccedoContainer?
    private weak var store: LandingPageContainersStore?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        autoScrollTimeInterval = Config.heroAutoScrollTimeInterval
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        heroSliderScrollView = HeroSliderScrollView()
        sliderIndicator = SliderIndicator()
        self.style()
        self.layout()
    }
    
    func configure(container: AccedoContainer, store: LandingPageContainersStore) {
        guard  container.playlistId != self.container?.playlistId else { return }
        self.container = container
        self.store = store
        setup { [weak self] in
            guard let self, let items else {return}
            heroSliderScrollView.configure(items: items, delegate: self)
            sliderIndicator.configure(count: items.count)
            heroSliderScrollView.snapToSlide(slideNumber: 1)
            configureAutoScroll(withInterval: autoScrollTimeInterval)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




extension HeroSliderTableViewCell {
    
    private func setup(onCompletion: (()-> Void)? = nil) {
        fetchEditorials(onCompletion: onCompletion)
    }
    
    private func fetchEditorials(onCompletion: (()-> Void)? = nil) {
        guard let container else {return }
        let block =  {
            if let onCompletion {
                DispatchQueue.main.async {
                    onCompletion()
                }
            }
        }
        
        if let playlistId = container.playlistId {
            APIMock.shared.getContainerItems(playlistId: playlistId, pageNumber: 0, pageSize: Config.pageSize) { [weak self] editorialResponse in
                guard let self, let editorialItems = editorialResponse.editorialItems else {
                    block()
                    return
                }
                self.items = editorialItems.compactMap({ $0.item })
                block()
            } failure: { errorMessage in
                print("HeroSliderTableViewCell fetchEditorials error \(errorMessage)")
                block()
            }
        }
    }
    
    private func style(){
        backgroundColor = ThemeColor.transparent
        contentView.backgroundColor = ThemeColor.transparent
        
        heroSliderScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        sliderIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout(){
        contentView.addSubview(heroSliderScrollView)
        contentView.addSubview(sliderIndicator)
        
        //indicators
        NSLayoutConstraint.activate([
            sliderIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            sliderIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
        //slider
        NSLayoutConstraint.activate([
            heroSliderScrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            heroSliderScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            heroSliderScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            sliderIndicator.topAnchor.constraint(equalToSystemSpacingBelow: heroSliderScrollView.bottomAnchor, multiplier: 1.5),
        ])
    }
    
    private func configureAutoScroll(withInterval: Int) {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(withInterval), repeats: true, block: { [weak self] _ in
            guard let self else { return }
            heroSliderScrollView.snapToNextSlide()
        })
    }
}


//MARK: Hero Slider Delegate
extension HeroSliderTableViewCell : HeroSliderDelegate {
    func didSnapToSlide(slideIndex: Int) {
        sliderIndicator.setActive(index: slideIndex)
        configureAutoScroll(withInterval: autoScrollTimeInterval)
    }
}
