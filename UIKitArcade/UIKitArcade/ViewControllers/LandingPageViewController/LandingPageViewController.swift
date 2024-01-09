//
//  LandingPageViewController.swift
//  UIKitArcade
//
//  Created by admin on 28/12/2023.
//

import Foundation
import UIKit

class LandingPageViewController : UIViewController {
    
    let store = LandingPageContainersStore()
    
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        tableView.register(LandscapeCarouselTableViewCell.self, forCellReuseIdentifier: LandscapeCarouselTableViewCell.reusableId)
        tableView.register(HeroSliderTableViewCell.self, forCellReuseIdentifier: HeroSliderTableViewCell.reusableId)
        tableView.register(NativeAdTableViewCell.self, forCellReuseIdentifier: NativeAdTableViewCell.reusableId)
        
        if let containers = APIMock.shared.getContainers() {
            self.containers = containers
            tableView.reloadData()
        }
    }
    
    func style() {
        view.backgroundColor = .red
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = ThemeColor.nero
        //tableView.contentInsetAdjustmentBehavior = .never
        
    }
    
    func layout() {
        [tableView].forEach(view.addSubview(_:))
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
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
        let container = containers[indexPath.item]
        if let cell = getTemplateCell(tableView, container: container, indexPath: indexPath)  {
            return cell
        }
        
        return UITableViewCell()
    }
}



extension LandingPageViewController {
    
    func getTemplateCell(_ tableView: UITableView, container: AccedoContainer, indexPath: IndexPath) -> UITableViewCell? {
        guard let template = container.template else {return nil}
        switch template {
        case ContainerTemplate.LANDING_HERO.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HeroSliderTableViewCell.reusableId, for: indexPath) as? HeroSliderTableViewCell {
                cell.configure(container: container, store: store)
                return cell
            }
        case ContainerTemplate.NATIVE_AD.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: NativeAdTableViewCell.reusableId, for: indexPath) as? NativeAdTableViewCell {
                cell.configure(container: container, store: store)
                return cell
            }
        case ContainerTemplate.DEFAULT_LANDSCAPE.rawValue:
            fallthrough
        default:
            if let cell =  tableView.dequeueReusableCell(withIdentifier: LandscapeCarouselTableViewCell.reusableId, for: indexPath) as? LandscapeCarouselTableViewCell {
                cell.configure(container: container, store: store)
                return cell
            }
        }
        return nil
    }
    
}
