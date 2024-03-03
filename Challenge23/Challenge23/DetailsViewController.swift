//
//  DetailsViewController.swift
//  Challenge23
//
//  Created by Mac on 01/03/2024.
//

import Foundation
import UIKit

class DetailsViewController : UIViewController {
    
    let countryItem : CountryItem
    
    let imageView = UIImageView()
    let label = UILabel()
    
    init(item: CountryItem) {
        countryItem = item
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
}


extension DetailsViewController {
    
    func configure() {
        title = "Country Details"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", image: nil, target: self, action: #selector(shareTapped))
        label.text = countryItem.name
        imageView.image = UIImage(named: countryItem.flagName)
    }
    
    func setup(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
    }
    
    func layout() {
        [imageView, label].forEach(view.addSubview(_:))
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            label.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 1),
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
    }
    
    @objc func shareTapped() {
        let activtiyController = UIActivityViewController(activityItems: [imageView.image as Any], applicationActivities: nil)
        present(activtiyController, animated: true)
    }
}
