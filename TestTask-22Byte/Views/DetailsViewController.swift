//
//  DetailsViewController.swift
//  TestTask-22Byte
//
//  Created by Nikolai  on 16.10.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private let nameLabel = UILabel()
    private let totalWinsLabel = UILabel()
    
    private var labelsStackView = UIStackView()
    
    var name = ""
    var totalWinCount = 0
    
    init(_ playerName: String) {
        super.init(nibName: nil, bundle: nil)
        self.name = playerName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        displayUserInfo()
    }
    
    private func setupViews() {
        title = "Player Details"
        view.backgroundColor = .init(red: 171/255, green: 237/255, blue: 216/255, alpha: 1)
        
        labelsStackView = UIStackView(arrangedSubviews: [nameLabel, totalWinsLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 2
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(labelsStackView)
    }
    
    private func displayUserInfo() {
        takeWins()
        nameLabel.text = "Имя: " + name
        totalWinsLabel.text = "Всего побед: " + String(totalWinCount)
        
    }
    
    private func takeWins() {
        for games in Base.shared.allGamesInfo {
            print(games)
            if games.name == name {
                if games.gameResult == "win" {
                    totalWinCount += 1
                }
            }
        }
        print(totalWinCount)
    }
}

//MARK: - Set Constaints

extension DetailsViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
}
