//
//  ViewController.swift
//  UIKitArcade
//
//  Created by admin on 05/12/2023.
//

import UIKit
class ViewController : UIViewController {
    
    typealias CustomValidation = PasswordTextField.CustomValidation
    
    let stackView = UIStackView()
    let newPasswordTextField = PasswordTextField(placeHolderText: "New Password")
    let statusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Re-enter new password")
    let resetButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

extension ViewController {
    func setup(){
        setupNewPassword()
        setupConfirmPassword()
        setupDismissKeyboardGesture()
    }
    
    func setupNewPassword(){
        let newPasswordValidation : CustomValidation = { text in
            guard let text, !text.isEmpty else {
                self.statusView.reset()
                return (false, "Enter your password")
            }
            // Valid characters
            let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$\\/#"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.statusView.reset()
                return (false, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
            }
            
            self.statusView.updateDisplay(text)
            if !self.statusView.validate(text) {
                return (false, "Your password should meet the requirments below")
            }
            
            return (true, "")
        }
        
        newPasswordTextField.customValidation = newPasswordValidation
        newPasswordTextField.delegate = self
        
    }
    
    func setupConfirmPassword() {
        let confirmPasswordValidation : CustomValidation = { text in
            guard let text, !text.isEmpty else {
                return (false, "Enter your password")
            }
            guard text == self.newPasswordTextField.text else {
                return (false, "Passwords do not match.")
            }
            return (true, "")
        }
        
        confirmPasswordTextField.customValidation = confirmPasswordValidation
        confirmPasswordTextField.delegate = self
    }
    
    func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.layer.cornerRadius = 5
        statusView.clipsToBounds = true
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: [])
        //resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .touchUpInside)
        
    }
    
    func layout() {
        [newPasswordTextField, statusView, confirmPasswordTextField, resetButton].forEach(stackView.addArrangedSubview)
        [stackView].forEach(view.addSubview)
        
        //StackView
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}



// MARK: PasswordTextFieldDelegate
extension ViewController : PasswordTextFieldDelegate {
    
    func editingChanged(_ sender: PasswordTextField) {
        if sender == newPasswordTextField {
            statusView.updateDisplay(sender.textField.text ?? "")
        }
    }
    
    func editingDidEnd(_ sender: PasswordTextField) {
        if sender == newPasswordTextField {
            self.statusView.shouldResetCriteria = false
            _ = newPasswordTextField.validate()
        }
        else if (sender == confirmPasswordTextField) {
            _ = confirmPasswordTextField.validate()
        }
    }
    
}

// MARK: Actions
extension ViewController {
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
}
