//
//  DetailsViewController.swift
//  FileManager
//
//  Created by admin on 15/12/2023.
//

import Foundation
import UIKit

class DetailsViewController : UIViewController {
    static let imageWidth = CGFloat(200)
    let imageName: String?
    let imageView = UIImageView()
    
    init(imageName: String) {
        self.imageName = imageName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "View Picture"
        navigationItem.largeTitleDisplayMode = .never
        style()
        layout()
    }
}

extension DetailsViewController {
    func style() {
        view.backgroundColor = .systemBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        if let imageName , let image = UIImage(named: imageName) {
            imageView.image = image
        }
    }
    
    func layout() {
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo:  view.trailingAnchor),
        ])
    }
}

