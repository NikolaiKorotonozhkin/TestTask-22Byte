//
//  GameViewController + Extension.swift
//  TestTask-22Byte
//
//  Created by Nikolai  on 15.10.2023.
//

import Foundation
import UIKit

extension GameViewController {
    
    func setupViews() {
        title = "\(playerName) vs Bender"
        view.backgroundColor = .white
        
        robotImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(robotImageView)
        
        robotButton.backgroundColor = .init(red: 255/255, green: 219/255, blue: 139/255, alpha: 1)
        robotButton.clipsToBounds = true
        robotButton.layer.cornerRadius = view.frame.width / 60
        robotButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(robotButton)
        
        rockButton.backgroundColor = .init(red: 113/255, green: 201/255, blue: 206/255, alpha: 1)
        rockButton.setImage(UIImage(named: "icons8-rock-100"), for: .normal)
        rockButton.clipsToBounds = true
        rockButton.layer.cornerRadius = view.frame.width / 60
        rockButton.translatesAutoresizingMaskIntoConstraints = false
        rockButton.addTarget(self, action: #selector(rockButtonPressed), for: .touchUpInside)
        rockButton.center.y = view.center.y - 200
        
        view.addSubview(rockButton)
        
        paperButton.backgroundColor = rockButton.backgroundColor
        paperButton.setImage(UIImage(named: "icons8-paper-100"), for: .normal)
        paperButton.clipsToBounds = true
        paperButton.layer.cornerRadius = view.frame.width / 60
        paperButton.translatesAutoresizingMaskIntoConstraints = false
        paperButton.addTarget(self, action: #selector(paperButtonPressed), for: .touchUpInside)
        view.addSubview(paperButton)
        
        scissorsButton.backgroundColor = rockButton.backgroundColor
        scissorsButton.setImage(UIImage(named: "icons8-barber-scissors-100"), for: .normal)
        scissorsButton.clipsToBounds = true
        scissorsButton.layer.cornerRadius = view.frame.width / 60
        scissorsButton.translatesAutoresizingMaskIntoConstraints = false
        scissorsButton.addTarget(self, action: #selector(scissorsButtonPressed), for: .touchUpInside)
        view.addSubview(scissorsButton)
        
        nextRoundButton.setTitle("Следующий раунд", for: .normal)
        nextRoundButton.setTitleColor(.black, for: .normal)
        nextRoundButton.backgroundColor = .init(red: 202/255, green: 222/255, blue: 252/255, alpha: 2)
        nextRoundButton.clipsToBounds = true
        nextRoundButton.layer.cornerRadius = view.frame.width / 60
        nextRoundButton.translatesAutoresizingMaskIntoConstraints = false
        nextRoundButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        view.addSubview(nextRoundButton)
        
        statusLabel.text = "Камень, Ножницы, Бумага?"
        statusLabel.font = .systemFont(ofSize: 26)
        statusLabel.clipsToBounds = true
        statusLabel.layer.cornerRadius = view.frame.width / 60
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusLabel)
        
        winLabel.text = "Победы:"
        view.addSubview(winLabel)
        winLabel.translatesAutoresizingMaskIntoConstraints = false
        
        loseLabel.text = "Проигрыш:"
        view.addSubview(loseLabel)
        loseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        drawLabel.text = "Ничья:"
        view.addSubview(drawLabel)
        drawLabel.translatesAutoresizingMaskIntoConstraints = false
        
        winRoundsCountLabel.text = String(winRoundsCount)
        view.addSubview(winRoundsCountLabel)
        winRoundsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        loseRoundsCountLabel.text = String(loseRoundsCount)
        view.addSubview(loseRoundsCountLabel)
        loseRoundsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        drawRoundsCountLabel.text = String(drawRoundsCount)
        view.addSubview(drawRoundsCountLabel)
        drawRoundsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        restartGameButton.setTitle("Новая игра", for: .normal)
        restartGameButton.backgroundColor = .init(red: 204/255, green: 168/255, blue: 233/255, alpha: 1)
        restartGameButton.clipsToBounds = true
        restartGameButton.layer.cornerRadius = view.frame.width / 60
        restartGameButton.translatesAutoresizingMaskIntoConstraints = false
        restartGameButton.addTarget(self, action: #selector(restartGameButtonPressed), for: .touchUpInside)
        view.addSubview(restartGameButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            scissorsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scissorsButton.widthAnchor.constraint(equalToConstant: view.frame.width / 4),
            scissorsButton.heightAnchor.constraint(equalToConstant: view.frame.height / 5),
            scissorsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 7),
            
            rockButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -view.frame.width / 3),
            rockButton.widthAnchor.constraint(equalToConstant: view.frame.width / 4),
            rockButton.heightAnchor.constraint(equalToConstant: view.frame.height / 5),
            rockButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 7),
            
            paperButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width / 3),
            paperButton.widthAnchor.constraint(equalToConstant: view.frame.width / 4),
            paperButton.heightAnchor.constraint(equalToConstant: view.frame.height / 5),
            paperButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height / 7),
            
            robotImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            robotImageView.widthAnchor.constraint(equalToConstant: view.frame.width / 5),
            robotImageView.heightAnchor.constraint(equalToConstant: view.frame.width / 5),
            robotImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            
            robotButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            robotButton.widthAnchor.constraint(equalToConstant: view.frame.width / 4),
            robotButton.heightAnchor.constraint(equalToConstant: view.frame.height / 5),
            robotButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.width / 4),
            
            nextRoundButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextRoundButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            nextRoundButton.heightAnchor.constraint(equalToConstant: view.frame.height / 18),
            nextRoundButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.height / 40),
            
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height / 20),
            
            winLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width / 20),
            winLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height / 5),
            
            loseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width / 20),
            loseLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height / 6.7),
            
            drawLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width / 20),
            drawLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height / 10),
            
            
            winRoundsCountLabel.leadingAnchor.constraint(equalTo: winLabel.trailingAnchor, constant: 5),
            winRoundsCountLabel.topAnchor.constraint(equalTo: winLabel.topAnchor),
            
            loseRoundsCountLabel.leadingAnchor.constraint(equalTo: loseLabel.trailingAnchor, constant: 5),
            loseRoundsCountLabel.topAnchor.constraint(equalTo: loseLabel.topAnchor),
            
            drawRoundsCountLabel.leadingAnchor.constraint(equalTo: drawLabel.trailingAnchor, constant: 5),
            drawRoundsCountLabel.topAnchor.constraint(equalTo: drawLabel.topAnchor),
            
            restartGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restartGameButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            restartGameButton.heightAnchor.constraint(equalToConstant: view.frame.height / 18),
            restartGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.height / 40)
        ])
    }
}
