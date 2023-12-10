//
//  MainAppViewController.swift
//  UIKitArcade
//
//  Created by admin on 09/12/2023.
//

import Foundation
import UIKit

enum UIKitArcadeCatalog : Int, CaseIterable {
    case PasswordReset = 0
    case HorizontalCarousel
    
    var description : String {
        switch self {
        case .PasswordReset : return "Password Reset"
        case .HorizontalCarousel: return "Horizontal Carousel"
        }
    }
    
    var toViewController: UIViewController.Type {
        switch self {
        case .PasswordReset : return PasswordResetViewController.self
        case .HorizontalCarousel : return HorizontalCarouselViewController.self
        }
    }
}



class MainAppViewController : UIViewController {
    
    let tableView = UITableView()
    let catalogItems = UIKitArcadeCatalog.allCases
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainAppViewController {
    
    func setup() {
        view.backgroundColor = .systemFill
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.rowHeight = 40
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func style() {
        [tableView].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 1)
        ])
        //view.setContentCompressionResistancePriority(.defaultHigh,for: .horizontal)
        tableView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}

extension MainAppViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catalogItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let catalogItem = catalogItems[indexPath.row]
        var configuration = cell.defaultContentConfiguration()
        configuration.text = catalogItem.description
        configuration.image = UIImage(systemName: "chevron.right")!
        cell.contentConfiguration = configuration
        return cell
    }
    
    
}

extension MainAppViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController else {return}
        let vc = catalogItems[indexPath.row].toViewController
        navigationController.pushViewController(vc.init(), animated: true)
    }
    
}
