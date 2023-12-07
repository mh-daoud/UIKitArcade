//
//  PasswordTextField.swift
//  UIKitArcade
//
//  Created by admin on 05/12/2023.
//

import Foundation
import UIKit

protocol PasswordTextFieldDelegate: AnyObject {
    func editingChanged(_ sender: PasswordTextField)
}

class PasswordTextField : UIView {
    
    let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill")?.withTintColor(.systemBlue))
    let textField = UITextField()
    let eyeButton = UIButton(type: .custom)
    let dividerView = UIView()
    let errorLabel = UILabel()
    
    weak var delegate: PasswordTextFieldDelegate?
    
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
        return CGSize(width: 200, height: 60)
    }
}




extension PasswordTextField {
    
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = false // true
        textField.delegate = self
        textField.placeholder = placeHolderText
        textField.keyboardType = .asciiCapable // to prevent entering emojys as passwords
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [
            .foregroundColor: UIColor.secondaryLabel
        ])
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye.circle")?.withTintColor(.systemBlue), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle")?.withTintColor(.systemBlue), for: .selected)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .primaryActionTriggered)
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .separator
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.font = .preferredFont(forTextStyle: .footnote)
        errorLabel.textColor = .systemRed
        errorLabel.text = "Your password must meet the requirements below."
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.isHidden = true
    }
    
    func layout(){
        [lockImageView, textField, eyeButton, dividerView, errorLabel].forEach(addSubview)
        
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

        //eyeButton
        NSLayoutConstraint.activate([
            eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        //divider
        NSLayoutConstraint.activate([
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        //errorMessage
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.topAnchor.constraint(equalToSystemSpacingBelow: dividerView.bottomAnchor, multiplier: 1),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        lockImageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        eyeButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)

    }
}


// MARK: Actions
extension PasswordTextField {
    @objc func togglePasswordView(_ Sender: Any){
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
    
    @objc func textFieldEditingChanged(_ Sender: UITextField) {
        delegate?.editingChanged(self)
    }
}


// MARK: TextFeild Delegate

extension PasswordTextField : UITextFieldDelegate {
    
}
