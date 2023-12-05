//
//  PasswordTextField.swift
//  UIKitArcade
//
//  Created by admin on 05/12/2023.
//

import Foundation
import UIKit

class PasswordTextField : UIView {
    
    let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill")?.withTintColor(.systemBlue))
    let textField = UITextField()
    let eyeButton = UIButton(type: .custom)
    let placeHolderText : String
    
    init(placeHolderText: String) {
        self.placeHolderText = placeHolderText
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}




extension PasswordTextField {
    
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemOrange
        
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = false // true
        //textField.delegate = self
        textField.placeholder = placeHolderText
        textField.keyboardType = .asciiCapable // to prevent entering emojys as passwords
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [
            .foregroundColor: UIColor.secondaryLabel
        ])
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye.circle")?.withTintColor(.systemBlue), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle")?.withTintColor(.systemBlue), for: .selected)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .primaryActionTriggered)
    }
    
    func layout(){
        [lockImageView, textField, eyeButton].forEach(addSubview)
        
        //LockImageView
        NSLayoutConstraint.activate([
            lockImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        //textfield
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1)
        ])
        textField.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)

        //eyeButton
        NSLayoutConstraint.activate([
            eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}


// MARK: Actions
extension PasswordTextField {
    @objc func togglePasswordView(_ Sender: Any){
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
}
