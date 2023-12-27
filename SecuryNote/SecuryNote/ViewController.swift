//
//  ViewController.swift
//  SecuryNote
//
//  Created by admin on 26/12/2023.
//


import UIKit
import LocalAuthentication

class ViewController : UIViewController {
    
    let secret = UITextView()
    let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nothing to see here"
        
        setup()
        style()
        layout()
    }
}

extension ViewController {
    func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustKeyboard), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
    }
    func style() {
        view.backgroundColor = .systemGray4
        
        secret.translatesAutoresizingMaskIntoConstraints = false
        secret.backgroundColor = .white
        secret.textColor = .black
        secret.layer.borderWidth = 1
        secret.layer.borderColor = UIColor.black.cgColor
        secret.layer.zPosition = 20
        secret.isHidden = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Authenticate", for: .normal)
        button.addTarget(self, action: #selector(authenticateTapped), for: .primaryActionTriggered)
        button.layer.zPosition = 10
    }
    
    func layout() {
        
        view.addSubview(secret)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            secret.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secret.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secret.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: secret.bottomAnchor, multiplier: 4)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func unlockSecretMessage() {
        secret.isHidden = false
        title = "Secret stuff!"
        
        if let text = KeychainWrapper.standard.string(forKey: "SecretMessage") {
            secret.text = text
        }
    }
}


//MARK: Actions
extension ViewController {
    @objc func adjustKeyboard(_ notification: NSNotification){
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        }
        else {
            let keyboardScreenEndFrame = keyboardValue.cgRectValue
            let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        secret.scrollIndicatorInsets = secret.contentInset
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
        
    }
    
    
    @objc func authenticateTapped(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage()
                    } else {
                        // error
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "Ok", style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            }
        } else {
            // no biometry
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        }
    }
    
    @objc func saveSecretMessage() {
        guard secret.isHidden == false else { return }
        
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        secret.resignFirstResponder()
        secret.isHidden = true
        title = "Nothing to see here"
    }
}
