//
//  ViewController.swift
//  UIKitArcade
//
//  Created by admin on 05/12/2023.
//

import UIKit
class ViewController : UIViewController {
   
    let newPasswordTextField = PasswordTextField(placeHolderText: "New Password")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension ViewController {
    func style() {
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func layout() {
        [newPasswordTextField].forEach(view.addSubview)
        NSLayoutConstraint.activate([
            newPasswordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newPasswordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
