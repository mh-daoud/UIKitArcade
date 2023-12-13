//
//  GridViewController.swift
//  UIKitArcade
//
//  Created by admin on 12/12/2023.
//

import Foundation
import UIKit


class GridViewController : UIViewController {
    
    lazy var compositionalCollectionView = CollectionViewCompositionalLayout()
    lazy var flowCollectionView = CollectionViewFlowLayout()
    
    let stackView = UIStackView()
    let compositionalLayoutButton = StateButton(title: "Compositional Layout")
    let flowLayoutButton = StateButton(title: "Flow Layout")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        configureButtons()
    }
}

extension GridViewController  {
    
    func style(){
        view.backgroundColor = .systemBackground
        
        compositionalCollectionView.translatesAutoresizingMaskIntoConstraints = false
        compositionalCollectionView.isHidden = true
        
        flowCollectionView.translatesAutoresizingMaskIntoConstraints = false
        flowCollectionView.isHidden = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
    }
    
    func layout(){
        [compositionalLayoutButton,flowLayoutButton].forEach(stackView.addArrangedSubview)
        [stackView, compositionalCollectionView, flowCollectionView].forEach(view.addSubview)
        
        //Stackview
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        //CompositionalCollectionView
        NSLayoutConstraint.activate([
            compositionalCollectionView.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
            compositionalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            compositionalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            compositionalCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        //FlowCollectionView
        NSLayoutConstraint.activate([
            flowCollectionView.topAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1),
            flowCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            flowCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            flowCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func configureButtons() {
        compositionalLayoutButton.button.addTarget(self, action: #selector(compositionalLayoutButtonTapped), for: .touchUpInside)
        flowLayoutButton.button.addTarget(self, action: #selector(flowLayoutButtonTapped), for: .touchUpInside)
        compositionalLayoutButton.button.sendActions(for: .touchUpInside)
    }
}

// MARK: Actions
extension GridViewController {
    @objc func compositionalLayoutButtonTapped(){
        resetFilters()
        compositionalLayoutButton.isSelected = true
        compositionalCollectionView.isHidden = false
    }
    
    @objc func flowLayoutButtonTapped(){
        resetFilters()
        flowLayoutButton.isSelected = true
        flowCollectionView.isHidden = false
        //...
    }
    
    private func resetFilters(){
        [compositionalLayoutButton,flowLayoutButton].forEach { _button in
            _button.isSelected = false
        }
        [compositionalCollectionView, flowCollectionView].forEach { _view in
            _view.isHidden = true
        }
    }
}
