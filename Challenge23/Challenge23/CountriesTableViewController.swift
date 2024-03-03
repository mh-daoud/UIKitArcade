//
//  ViewController.swift
//  Challenge23
//
//  Created by Mac on 29/02/2024.
//

import UIKit

class CountriesTableViewController: UIViewController {
    
    let tableView = UITableView()
    var countries: [CountryItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
        
        // Do any additio.nal setup after loading the view.
    }
}

extension CountriesTableViewController {
    func setup() {
        title = "Countries List"
        
        countries.append(CountryItem(name: "Estonia", flagName: "estonia"))
        countries.append(CountryItem(name: "France", flagName: "france"))
        countries.append(CountryItem(name: "Germany", flagName: "germany"))
        countries.append(CountryItem(name: "Ireland", flagName: "ireland"))
        countries.append(CountryItem(name: "Italy", flagName: "italy"))
        countries.append(CountryItem(name: "Monaco", flagName: "monaco"))
        countries.append(CountryItem(name: "Nigeria", flagName: "nigeria"))
        countries.append(CountryItem(name: "Poland", flagName: "poland"))
        countries.append(CountryItem(name: "Russia", flagName: "russia"))
        countries.append(CountryItem(name: "Spain", flagName: "spain"))
        countries.append(CountryItem(name: "United Kingdom", flagName: "uk"))
        countries.append(CountryItem(name: "United State of America", flagName: "us"))
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryItemTableViewCell.self, forCellReuseIdentifier: CountryItemTableViewCell.reusableId)
    }
    
    func style() {
        
    }
    
    func layout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 1),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


extension CountriesTableViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryItemTableViewCell.reusableId, for: indexPath) as? CountryItemTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(item: countries[indexPath.row])
        return cell
    }
}

extension CountriesTableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = countries[indexPath.row]
        let detailViewController = DetailsViewController(item: item)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
