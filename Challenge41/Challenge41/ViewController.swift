//
//  ViewController.swift
//  Challenge23
//
//  Created by Mac on 29/02/2024.
//

import UIKit

class ViewController: UIViewController {
    let stackView = UIStackView()
    let label = UILabel()
    let button = UIButton()
    
    var words = [String]()
    var selectedWord = ""
    var wrongAnswers = 0
    var roundNumber = 1
    var usedLetters = [Character]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setup()
        style()
        layout()
        // Do any additional setup after loading the view.
    }
}

extension ViewController {
    func setup() {
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                words = startWords.components(separatedBy: "\n")
                loadWord()
                updateTitle()
            }
        }
        
        view.backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title2)
        stackView.addArrangedSubview(label)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.configuration = UIButton.Configuration.filled()
        button.setTitle("Guess letter", for: [])
        button.addTarget(self, action: #selector(guessButtonTapped), for: .primaryActionTriggered)
        stackView.addArrangedSubview(button)
        
        
        stackView.spacing = 24
        stackView.axis = .vertical
    }
    
    func loadWord() {
        let randomIndex = (0...words.count).randomElement() ?? 0
        selectedWord = words.remove(at: randomIndex)
        label.text = String(repeating: "?", count: selectedWord.count)
        wrongAnswers = 0
        usedLetters = []
    }
    
    func updateTitle() {
        title = "Round \(roundNumber) wrong Answer \(wrongAnswers)/7"
    }
    
    func style() {
        
    }
    
    func layout() {
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    func checkUserGuess(_ guess: String) {
        guard guess.count == 1, label.text != nil else {
            showMessage("Please stick to the rules, enter one letter only")
            return
        }
        if let letter = guess.first, !usedLetters.contains(where: { usedLetter in
            usedLetter.lowercased() == letter.lowercased()
        }), selectedWord.contains(where: { wordLetter in
            wordLetter.lowercased() == letter.lowercased()
        }) {
            usedLetters.append(letter)
           
            label.text = ""
            var correctLetters = 0
            for letterInSelectedWord in selectedWord {
                if usedLetters.contains(where: { usedLetter in
                    usedLetter == letterInSelectedWord
                }) {
                    label.text! += String(letterInSelectedWord)
                    correctLetters += 1
                }
                else if  letter == letterInSelectedWord {
                    label.text! += String(letterInSelectedWord)
                    correctLetters += 1
                } else {
                    label.text! += "?"
                }
            }
            if correctLetters == selectedWord.count {
                userWin()
                return
            }
        }
        else {
            wrongAnswers += 1
            if wrongAnswers >=  7 {
                userLose()
            }
            updateTitle()
            showMessage("Wrong guess try again", "You have tried \(wrongAnswers) times...")
        }
        
    }
    
    func showMessage(_ title: String, _ message: String? = nil) {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        errorAlert.addAction(.init(title: "Okey!", style: .default))
        present(errorAlert, animated: true)
    }
    
    func userLose() {
        showMessage("Ohh ....", "You lost, you reach round \(roundNumber), good luck next time")
    }
    
    func userWin() {
        showMessage("Yay!", "You won, you completed round \(roundNumber), good luck in the next round")
        roundNumber = roundNumber + 1
        loadWord()
        updateTitle()
    }
}


//MARK: Actions
extension ViewController {
    @objc func guessButtonTapped() {
        let alertVC = UIAlertController(title: "Try to guess a letter", message: "Please enter only a single letter", preferredStyle: .alert)
        alertVC.addTextField { field in
            field.keyboardType = .alphabet
        }
        alertVC.addAction(.init(title: "Submit", style: .default, handler: { [weak self] _ in
            guard let self else {
                return
            }
            if let guess = alertVC.textFields?.first?.text {
                checkUserGuess(guess)
            }
        }))
        alertVC.addAction(.init(title: "Need to think more ...", style: .default))
        present(alertVC, animated: true)
    }
}
