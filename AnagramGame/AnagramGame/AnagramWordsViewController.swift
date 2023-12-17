//
//  AnagramWordsViewController.swift
//  AnagramGame
//
//  Created by admin on 16/12/2023.
//

import UIKit



class AnagramWordsViewController : UIViewController {
    
    static let basicCellReusableId = "basic_cell_id"
    
    let tableView = UITableView()
    var dataSource: UITableViewDiffableDataSource<Section,String>!
    var allWords = [String]()
    var usedWords = [String]()
    
    enum Section {
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
        startGame()
    }
}

extension AnagramWordsViewController {
    
    func setup(){
        
        setupTableView()
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Restart", style: .plain, target: self, action: #selector(startGame))
        
    }
    
    func setupTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: AnagramWordsViewController.basicCellReusableId)
        setupDataSource()
    }
    
    private func setupDataSource(){
        dataSource = UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: AnagramWordsViewController.basicCellReusableId, for: indexPath)
            var configuration = cell.defaultContentConfiguration()
            configuration.text = itemIdentifier
            cell.contentConfiguration = configuration
            return cell
        }
        
        var snapShot = NSDiffableDataSourceSnapshot<Section,String>()
        snapShot.appendSections([.main])
        snapShot.appendItems(usedWords)
        dataSource.apply(snapShot, animatingDifferences: false)
        dataSource.defaultRowAnimation = .automatic
    }
    
    func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        var snapShot = NSDiffableDataSourceSnapshot<Section,String>()
        snapShot.appendSections([.main])
        snapShot.appendItems(usedWords)
        dataSource.apply(snapShot, animatingDifferences: false)
       
    }
    
    func submit(_ answer: String) {
        
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    var oldSnapshot = dataSource.snapshot()
                    oldSnapshot.appendItems([answer], toSection: .main)
                    dataSource.apply(oldSnapshot, animatingDifferences: true)
                    return
                }else {
                    showError(errorTitle: "Word not recognised",
                              errorMessage: "You can't just make them up, you know!")
                }
            } else {
                showError(errorTitle : "Word used already",
                          errorMessage : "Be more original!")
            }
        } else {
            guard let title = title?.lowercased() else { return }
            showError(errorTitle: "Word not possible",
                      errorMessage:"You can't spell that word from \(title)")
        }
    }
    
    private func showError(errorTitle: String, errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let textChecker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledWordRange = textChecker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledWordRange.location == NSNotFound
    }
}



// MARK: Actions
extension AnagramWordsViewController {
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
}
