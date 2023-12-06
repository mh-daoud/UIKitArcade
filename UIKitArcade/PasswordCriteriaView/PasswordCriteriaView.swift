//
//  PasswordCriteriaView.swift
//  UIKitArcade
//
//  Created by admin on 06/12/2023.
//

import Foundation
import UIKit

class PasswordCriteriaView : UIView {
    
    let stackView = UIStackView()
    let imageView = UIImageView()
    let label = UILabel()
    
    let checkmarkImage = UIImage(systemName: "checkmark.circle")!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    let xmarkImage = UIImage(systemName: "xmark.circle")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    let ciricleImage = UIImage(systemName: "circle")!.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
    
    var isCriteriaMet: Bool = false {
        didSet {
            if isCriteriaMet {
                imageView.image = checkmarkImage
            }
            else {
                imageView.image = xmarkImage
            }
        }
    }
    
    func reset(){
        isCriteriaMet = false
        imageView.image = ciricleImage
    }
    
    init(criteriaTitle: String) {
        super.init(frame: .zero)
        
        label.text = criteriaTitle
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 40)
    }
}




extension PasswordCriteriaView {
    
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        //Stack View
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        //stackView.alignment = .fill
        
        //icon
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = ciricleImage
        
        //label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
    }
    
    func layout(){
        [imageView,label].forEach(stackView.addArrangedSubview)
        [stackView].forEach(addSubview)
        
        //stack view
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        //icon view
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}
