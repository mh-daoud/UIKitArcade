//
//  BadgeCell.swift
//  UIKitArcade
//
//  Created by admin on 13/12/2023.
//

import Foundation
import UIKit

class BadgeCell: UICollectionViewCell {
    static let reusableId = "badge_view"
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        didSet {
            configureCornerRadius()
        }
    }
    
    override var bounds: CGRect {
        didSet {
            configureCornerRadius()
        }
    }
    
    func configureCornerRadius(){
        let width = contentView.frame.width
        layer.cornerRadius = width / 2
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
}

extension BadgeCell {
    
    func style(){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = .systemGreen
        label.textAlignment = .center
        
        clipsToBounds = true
        configureCornerRadius()
    }
    
    func layout(){
        [label].forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        configureCornerRadius()
    }
}

