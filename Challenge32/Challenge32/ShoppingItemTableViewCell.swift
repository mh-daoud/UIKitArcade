//
//  CustomView.swift
//
//
//  Created by Mac on 03/03/2024.
//

import Foundation
import UIKit

class ShoppingItemTableViewCell: UITableViewCell {
    static let reusableId : String = "shopping_item_cell_reusable_id"
    
    let nameLabel = UILabel()
    let quantityLabel = UILabel()
    let descriptionLabel = UILabel()
    var descrptionTopConstraints : NSLayoutConstraint?
    var nameLabelBottomConstraints : NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ShoppingItemTableViewCell {
    func setup(){
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .preferredFont(forTextStyle: .title3)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.font = .preferredFont(forTextStyle: .caption1)
        quantityLabel.textColor = .black
        quantityLabel.textAlignment = .left
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .preferredFont(forTextStyle: .caption2)
        descriptionLabel.textColor = .black
        descriptionLabel.isHidden = true
        descriptionLabel.textAlignment = .left
        
    }
    
    func layout(){
        [nameLabel, quantityLabel, descriptionLabel].forEach(contentView.addSubview(_:))
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 1),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 1),
            
            quantityLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: quantityLabel.trailingAnchor, multiplier: 1),
            
           
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: descriptionLabel.bottomAnchor, multiplier: 1),
        ])
        descriptionLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        descrptionTopConstraints = descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 1)
        nameLabelBottomConstraints =  contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: nameLabel.bottomAnchor, multiplier: 1)
        
        descrptionTopConstraints?.isActive = false
        nameLabelBottomConstraints?.isActive = true
    }
    
    func configure(shoppingItem: ShoppingItem) {
        nameLabel.text = shoppingItem.name
        quantityLabel.text = String(shoppingItem.quantity)
        if let description = shoppingItem.description {
            descriptionLabel.text = description
            descriptionLabel.isHidden = false
            
            nameLabelBottomConstraints?.isActive = false
            descrptionTopConstraints?.isActive = true
        }
        else {
            descriptionLabel.isHidden = true
            descriptionLabel.text = ""
            
            nameLabelBottomConstraints?.isActive = true
            descrptionTopConstraints?.isActive = false
        }
    }
}

