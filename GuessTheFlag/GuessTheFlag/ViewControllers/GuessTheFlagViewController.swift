//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by admin on 15/12/2023.
//

import UIKit

class GuessTheFlagViewController: UIViewController {
    
    
    var firstButton : UIButton!
    var secondButton : UIButton!
    var thirdButton: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var totalAskedQuestion = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
        
        askQuestion()
    }
}



extension GuessTheFlagViewController {
    
    func setup(){
        
        firstButton = makeButton()
        firstButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        firstButton.tag = 0
        
        secondButton = makeButton()
        secondButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        secondButton.tag = 1
        
        thirdButton = makeButton()
        thirdButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        thirdButton.tag = 2
        
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")
    }
    
    func style(){
        view.backgroundColor = .systemBackground
    }
    
    func layout() {
        [firstButton,secondButton,thirdButton].forEach(view.addSubview(_:))
        
        //first button
        NSLayoutConstraint.activate([
            firstButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        //second button
        NSLayoutConstraint.activate([
            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 30),
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        //third button
        NSLayoutConstraint.activate([
            thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 30),
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        [firstButton,secondButton,thirdButton].forEach { (button: UIView) in
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 200),
                button.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
    }
    
    func makeButton(withTitle title : String? = nil, withImage imageName: String? = nil) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.tintColor = .systemBlue
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        if let title {
            button.setTitle(title, for: [])
            button.titleLabel?.font = .preferredFont(forTextStyle: .title2)
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.titleLabel?.textColor = .white
        }
        else if let imageName {
            button.setImage(UIImage(named: imageName), for: [])
        }
        
        return button
    }
    
    func askQuestion(_ alertAction: UIAlertAction? = nil) {
        countries.shuffle()
        firstButton.setImage(UIImage(named: countries[0]), for: .normal)
        secondButton.setImage(UIImage(named: countries[1]), for: .normal)
        thirdButton.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = "Q:\(totalAskedQuestion)-10 \(countries[correctAnswer].uppercased()) score: \(score)"

    }
    
}


// MARK: Actions

extension GuessTheFlagViewController {
    
    @objc func buttonTapped(_ sender: UIButton) {
        var title: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong! Thats the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        totalAskedQuestion += 1
        let ac = UIAlertController(title: title, message: "Your \(totalAskedQuestion  > 10 ? "final" : "") score is \(score).", preferredStyle: .alert)
        if totalAskedQuestion > 10 {
            ac.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { [weak self] action in
                guard let self else {
                    return
                }
                totalAskedQuestion = 0
                score = 0
                askQuestion(action)
            }))
        }
        else {
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        }
        
        present(ac, animated: true)
    }
}
