//
//  LandscapeShowCard.swift
//  UIKitArcade
//
//  Created by admin on 30/12/2023.
//

import Foundation
import UIKit

class PortraitCardCollectionViewCell : UICollectionViewCell {
    static let reusableId = "portrait_card_collection_view_cell_id"
    
    var portraitCardView = PortraitCard()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    func configure(item: EditorialItem) {
        setup(item: item)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        portraitCardView.imageView.image = nil
    }
}


extension PortraitCardCollectionViewCell {
    func setup(item: EditorialItem) {
        portraitCardView.configure(item: item)
    }
    
    func style(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        portraitCardView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        contentView.addSubview(portraitCardView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            portraitCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            portraitCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            portraitCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            portraitCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
