//
//  ViewController.swift
//  TestTask-22Byte
//
//  Created by Nikolai  on 15.10.2023.
//

import UIKit
import Foundation

class MenuViewController: UIViewController {
    
    var gameButton = UIButton()
    var resultsButton = UIButton()
    var textField = UITextField()
    var name = "Player"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    @objc func gameButtonPressed() {
        if textField.text == "" {
            name = "Player"
        } else {
            name = textField.text ?? ""
        }
        
        let gameViewController = GameViewController()
        gameViewController.playerName = name
        navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    @objc func resultsButtonPressed() {
        let resultsViewController = ResultsViewController()
        navigationController?.pushViewController(resultsViewController, animated: true)
    }
}

extension MenuViewController {
    private func setupViews() {
        view.backgroundColor = .init(red: 171/255, green: 237/255, blue: 216/255, alpha: 1)
        
        let backItem = UIBarButtonItem()
        backItem.title = "Меню"
        navigationItem.backBarButtonItem = backItem
        
        gameButton.setTitle("Start Game", for: .normal)
        gameButton.titleLabel?.font = .systemFont(ofSize: 30)
        gameButton.backgroundColor = .init(red: 70/255, green: 205/255, blue: 207/255, alpha: 1)
        gameButton.layer.cornerRadius = 8
        gameButton.translatesAutoresizingMaskIntoConstraints = false
        gameButton.addTarget(self, action: #selector(gameButtonPressed), for: .touchUpInside)
        view.addSubview(gameButton)
        
        resultsButton.setTitle("Results", for: .normal)
        resultsButton.titleLabel?.font = .systemFont(ofSize: 30)
        resultsButton.backgroundColor = .init(red: 72/255, green: 70/255, blue: 109/255, alpha: 1)
        resultsButton.layer.cornerRadius = 8
        resultsButton.translatesAutoresizingMaskIntoConstraints = false
        resultsButton.addTarget(self, action: #selector(resultsButtonPressed), for: .touchUpInside)
        view.addSubview(resultsButton)
        
        textField.placeholder = " Имя игрока"
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.layer.borderColor = .init(red: 61/255, green: 132/255, blue: 168/255, alpha: 1)
        textField.layer.borderWidth = 4
        textField.font = .systemFont(ofSize: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            gameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gameButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height / 8),
            gameButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            gameButton.heightAnchor.constraint(equalToConstant: view.frame.height / 18),
            
            resultsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultsButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            resultsButton.heightAnchor.constraint(equalToConstant: view.frame.height / 18),
            resultsButton.topAnchor.constraint(equalTo: gameButton.bottomAnchor, constant: 30),
            
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            textField.heightAnchor.constraint(equalToConstant: view.frame.height / 18),
            textField.topAnchor.constraint(equalTo: resultsButton.bottomAnchor, constant: 30)
            
        ])
    }
}
