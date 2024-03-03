//
//  CountryItemTableViewCell.swift
//  Challenge23
//
//  Created by Mac on 29/02/2024.
//

import Foundation
import UIKit


class CountryItemTableViewCell: UITableViewCell {
    static let reusableId = "country_item_table_view_reusable_id"
    
    var uiImageView = UIImageView()
    var container = UIView()
    var label = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    
    
    func configure(item: CountryItem) {
        uiImageView.image = UIImage(named: item.flagName)
        label.text = item.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CountryItemTableViewCell {
    func setup() {
        uiImageView.translatesAutoresizingMaskIntoConstraints = false
        //uiImageView.contentMode = .scaleAspectFit
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .darkText
        
        container.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        [uiImageView,label].forEach(contentView.addSubview(_:))
        NSLayoutConstraint.activate([
            uiImageView.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor),
            uiImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            uiImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            uiImageView.widthAnchor.constraint(equalTo: uiImageView.heightAnchor, multiplier: 1),
            
            label.centerYAnchor.constraint(equalTo: uiImageView.centerYAnchor),
            label.leadingAnchor.constraint(equalToSystemSpacingAfter: uiImageView.trailingAnchor, multiplier: 1),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        let heightConstrains = uiImageView.heightAnchor.constraint(equalToConstant: 50)
        heightConstrains.isActive = true
        heightConstrains.priority = .defaultHigh
    }
    
}
