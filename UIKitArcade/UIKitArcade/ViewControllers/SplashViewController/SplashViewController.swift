//
//  SplashViewController.swift
//  UIKitArcade
//
//  Created by admin on 13/01/2024.
//

import Foundation
import UIKit

class SplashViewController : UIViewController {
    let stackView = UIStackView()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension SplashViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.textAlignment = .center
        label.text = "Welcome"
    }
    
    func layout() {
        stackView.addArrangedSubview(label)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func testing() async throws {
        try await withThrowingTaskGroup(of: (Int, Double).self) { group in
            group.addTask {
                return (Int.random(in: 0...100), Double.random(in: 0...5))
            }
            
            for try await (id, val) in group {
                
            }
        }
    }
}

