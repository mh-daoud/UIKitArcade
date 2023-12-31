//
//  LandingPageViewController.swift
//  UIKitArcade
//
//  Created by admin on 28/12/2023.
//

import Foundation
import UIKit

class LandingPageViewController : UIViewController {
    
    lazy var tableView : UITableView = {
        
        let view = UITableView()
        view.dataSource = self
        view.rowHeight = UITableView.automaticDimension
        return view
    }()
    
    var containers : [AccedoContainer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}



extension LandingPageViewController {
    func setup() {
        title = "Landing Page"
        tableView.register(LandscapeCarouselTableViewCell.self, forCellReuseIdentifier: LandscapeCarouselTableViewCell.reusableId)

        if let containers = APIMock.shared.getContainers() {
            self.containers = containers
            tableView.reloadData()
        }
    }
    
    func style() {
        //view.backgroundColor = .systemBackground
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = ThemeColor.nero
        
    }
    
    func layout() {
        [tableView].forEach(view.addSubview(_:))
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}



extension LandingPageViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: LandscapeCarouselTableViewCell.reusableId, for: indexPath) as? LandscapeCarouselTableViewCell  {
            cell.configure(container: containers[indexPath.item])
            return cell
        }
        
        return UITableViewCell()
    }
}
