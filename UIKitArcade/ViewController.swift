//
//  ViewController.swift
//  UIKitArcade
//
//  Created by admin on 05/12/2023.
//

import UIKit
class ViewController : UIViewController {

    let stackView = UIStackView()
    let newPasswordTextField = PasswordTextField(placeHolderText: "New Password")
    let upperCaseCriteria = PasswordCriteriaView(criteriaTitle: "uppercase letter (A-Z)")
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension ViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        upperCaseCriteria.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        [newPasswordTextField, upperCaseCriteria].forEach(stackView.addArrangedSubview)
        [stackView].forEach(view.addSubview)
        
        //StackView
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
