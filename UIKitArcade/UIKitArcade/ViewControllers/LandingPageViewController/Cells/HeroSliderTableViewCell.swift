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
    var container: AccedoContainer!
    var items: [EditorialItem]? = nil
    var heroSliderScrollView : HeroSliderScrollView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func configure(container: AccedoContainer) {
        self.container = container
        setup { [weak self] in
            guard let self, let items else {return}
            self.heroSliderScrollView.configure(items: items)
        }
        style()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




extension HeroSliderTableViewCell {
    
    func setup(onCompletion: (()-> Void)? = nil) {
        heroSliderScrollView = HeroSliderScrollView()
        fetchEditorials(onCompletion: onCompletion)
    }
    
    private func fetchEditorials(onCompletion: (()-> Void)? = nil) {
        
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
    
    func style(){
        backgroundColor = ThemeColor.transparent
        contentView.backgroundColor = ThemeColor.transparent
        heroSliderScrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout(){
        contentView.addSubview(heroSliderScrollView)
        
        NSLayoutConstraint.activate([
            heroSliderScrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            heroSliderScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            heroSliderScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            heroSliderScrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
