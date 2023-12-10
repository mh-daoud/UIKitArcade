//
//  ViewController.swift
//  UIKitArcade
//
//  Created by admin on 05/12/2023.
//

import UIKit
class PasswordResetViewController : UIViewController {
    
    typealias CustomValidation = PasswordTextField.CustomValidation
    
    let stackView = UIStackView()
    let newPasswordTextField = PasswordTextField(placeHolderText: "New Password")
    let statusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Re-enter new password")
    let resetButton = UIButton(type: .system)
    var alertController: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

extension PasswordResetViewController {
    func setup(){
        setupNewPassword()
        setupConfirmPassword()
        setupDismissKeyboardGesture()
        setupKeyboardHiding()
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
    
    func setupKeyboardHiding(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func style() {
        view.backgroundColor = .systemBackground
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
        resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .touchUpInside)
        
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
extension PasswordResetViewController : PasswordTextFieldDelegate {
    
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
extension PasswordResetViewController {
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func resetPasswordButtonTapped(){
        view.endEditing(true)
        
        let isValidNewPassword = newPasswordTextField.validate()
        let isValidConfirmPassword = confirmPasswordTextField.validate()
        
        if isValidNewPassword && isValidConfirmPassword {
            showAlert(title: "Success", message: "You have successfully changed your password.")
        }
    }
    
    private func showAlert(title: String, message: String) {
        alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        guard let alertController else {
            return
        }
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
    
}


// MARK: Keyboard Notifications
extension PasswordResetViewController {
    @objc func keyboardWillShow(sender: NSNotification ){
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldbottomY = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldbottomY.origin.y + convertedTextFieldbottomY.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldbottomY.origin.y
            let newFrameOffset = (textBoxY - keyboardTopY/2) * -1
            view.frame.origin.y = newFrameOffset
        }
        
        print("foo - userInfo: \(userInfo)")
        print("foo - keyboardFrame: \(keyboardFrame)")
        print("foo - currentTextField: \(currentTextField)")
    }
    @objc func keyboardWillHide(sender: NSNotification){
        view.frame.origin.y = 0
    }
}
