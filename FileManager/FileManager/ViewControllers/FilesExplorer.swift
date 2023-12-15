//
//  FilesExplorer.swift
//  FileManager
//
//  Created by admin on 15/12/2023.
//

import UIKit

class FilesExplorer: UIViewController {
    
    static let basicCellReusableId = "basic_cell_reusable_id"
    
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    var fileNames = [String]()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        loadFiles()
        style()
        layout()
        // Do any additional setup after loading the view.
    }
    
    
}


extension  FilesExplorer {
    
    func loadFiles() {
        if let files = try? fm.contentsOfDirectory(atPath: path) {
            for fileName in files.sorted() {
                if fileName.hasPrefix("nssl") {
                    fileNames.append(fileName)
                }
            }
        }
    }
    
    func style(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: FilesExplorer.basicCellReusableId)
    }
    
    func layout(){
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func navigateToImageDetailsScreen(imageName: String) {
        let detailsVC = DetailsViewController(imageName: imageName)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}


extension FilesExplorer : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToImageDetailsScreen(imageName: fileNames[indexPath.row])
    }
}

extension FilesExplorer: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fileNames.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilesExplorer.basicCellReusableId, for: indexPath)
        let fileName = fileNames[indexPath.row]
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = fileName
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: .title2)
        cell.contentConfiguration = contentConfiguration
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}


