//
//  BasicCell.swift
//  UIKitArcade
//
//  Created by admin on 14/12/2023.
//

import Foundation
import UIKit

class BasicCell : UICollectionViewCell {
    static let reusableId = "basic_cell"
    static let size = CGSize(width: 160, height: 280)
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override var intrinsicContentSize: CGSize {
//        return BasicCell.size
//    }
}

extension BasicCell {
    
    func style(){

        contentView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView = UIView()
        backgroundView?.backgroundColor = .systemFill
        contentView.layer.cornerRadius = 8
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
    }
    
    func layout(){
        [label].forEach(contentView.addSubview(_:))
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configureCell(with model: CardModel){
        label.text = model.value
    }
}
