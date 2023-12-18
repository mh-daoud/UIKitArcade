//
//  ViewController.swift
//  PetitionBrowser
//
//  Created by admin on 18/12/2023.
//

import UIKit

struct Petition: Codable, Hashable {
    var title: String
    var body: String
    var signatureCount: Int
}

struct Petitions: Codable {
    var results: [Petition]
}

enum Section {
    case main
}

class PetitionTableViewController: UIViewController {
    
    static let basicCellReusableId = "basic_cell"
    
    var tableView = UITableView()
    var dataSource : UITableViewDiffableDataSource<Section,Petition>!
    var petitions = [Petition]()
    
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        setup()
    }
    
    
}

extension PetitionTableViewController {
    func setup() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: PetitionTableViewController.basicCellReusableId)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(creditsTapped)),
                                              UIBarButtonItem(image: UIImage(systemName: "text.magnifyingglass"), style: .plain, target: self, action: #selector(searchTapped))
        ]
        
        fetchPetitions()
        setupDataSource()
    }
    
    func setupDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: PetitionTableViewController.basicCellReusableId, for: indexPath)
            var configuraion = cell.defaultContentConfiguration()
            configuraion.text = itemIdentifier.title
            configuraion.secondaryText = itemIdentifier.body
            cell.contentConfiguration = configuraion
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section,Petition>()
        snapshot.appendSections([.main])
        snapshot.appendItems(petitions)
        dataSource.apply(snapshot,animatingDifferences: false)
    }
    
    
    func fetchPetitions() {
        let resourceToLoad = "\( self.navigationController?.tabBarItem.tag == 1 ? "Petitions2" : "Petitions")"
        let path = Bundle.main.path(forResource:  resourceToLoad, ofType: "txt")
        if let path, let fileContents = FileManager.default.contents(atPath: path) {
            let decoder = JSONDecoder()
            if let jsonPetitions = try? decoder.decode(Petitions.self, from: fileContents) {
                petitions = jsonPetitions.results
            }
            else {
                showError()
            }
        }
        else {
            showError()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func loadDataSource(_ petitions: [Petition]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Petition>()
        snapshot.appendSections([.main])
        snapshot.appendItems(petitions)
        dataSource.defaultRowAnimation = .automatic
        dataSource.apply(snapshot,animatingDifferences: true)
    }
}

extension PetitionTableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController(petition: petitions[indexPath.row])
        if let navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}


//MARK: Actions
extension PetitionTableViewController {
    @objc func creditsTapped() {
        let vc = UIAlertController(title: "Credits", message: "Data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Ok", style: .default))
        present(vc, animated: true)
    }
    
    @objc func searchTapped() {
        let vc = UIAlertController(title: "Search Petitions", message: "Search for ...", preferredStyle: .alert)
        vc.addTextField()
        vc.addAction(UIAlertAction(title: "Search", style: .default, handler: { [weak self] _ in
            guard let self else {
                return
            }
            guard let searchText = vc.textFields?[0].text, !searchText.isEmpty else {
                loadDataSource(petitions)
                return
            }
            loadDataSource(self.petitions.filter({ $0.title.contains(searchText) || $0.body.contains(searchText)}))
        }))
        present(vc, animated: true)
    }
}
