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
    var allWords = [String]()
    var usedWords = [String]()
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        problemLabel = UILabel()
        problemLabel.translatesAutoresizingMaskIntoConstraints = false
        problemLabel.textAlignment = .right
        problemLabel.text = ""
        view.addSubview(problemLabel)
        
        NSLayoutConstraint.activate([
            problemLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            problemLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
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
        
        problemLabel.text = allWords.randomElement()
    }


}

