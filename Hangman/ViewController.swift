//
//  ViewController.swift
//  Hangman
//
//  Created by Yoo Hwa Park on 2020/04/23.
//  Copyright © 2020 Yoo Hwa Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var problemLabel: UILabel!
    var currentAnswer = ""
    var allWords = [String]()
    var usedWords = [String]()
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var score = 0
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        problemLabel = UILabel()
        problemLabel.translatesAutoresizingMaskIntoConstraints = false
        problemLabel.textAlignment = .right
        problemLabel.text = ""
        problemLabel.font = UIFont.systemFont(ofSize: 32)
        view.addSubview(problemLabel)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            problemLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            problemLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100),
            buttonsView.widthAnchor.constraint(equalToConstant: 280),
            buttonsView.heightAnchor.constraint(equalToConstant: 392),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        let width = 70
        let height = 56
        var counter = 0
        var alphabet = ""
        for row in 0..<7 {
            for col in 0..<4 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
                
                if counter < 26 {
                    alphabet = String(UnicodeScalar(UInt8(Int(Character("A").asciiValue!) + counter)))
                } else {
                    alphabet = ""
                }
                
                letterButton.setTitle(alphabet, for: .normal)
                
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                
                buttonsView.addSubview(letterButton)
                
                letterButtons.append(letterButton)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                counter += 1
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let startWordsURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["EMPTY"]
        }
        
        currentAnswer = allWords.randomElement()!
        problemLabel.text = String(repeating: "?", count: currentAnswer.count)
        
        title = "Score: \(score)"
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        var flag = true
        var temp = currentAnswer
        
        while flag {
            if let range = temp.rangeOfCharacter(from: CharacterSet(charactersIn: buttonTitle)) {
                temp.replaceSubrange(range, with: "-")
                problemLabel.text?.replaceSubrange(range, with: buttonTitle)
                print(range)
            } else {
                flag = false
            }
        }
        
        activatedButtons.append(sender)
        sender.isHidden = true
    }

}

