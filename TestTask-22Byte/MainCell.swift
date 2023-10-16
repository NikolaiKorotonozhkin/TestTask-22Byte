//
//  MainCell.swift
//  TestTask-22Byte
//
//  Created by Nikolai  on 16.10.2023.
//

import UIKit

class MainCell: UITableViewCell {
    
    static var identifier: String {
        "MainCell"
    }
    
    private let nameLable = UILabel()
    private let gameResultLable = UILabel()
    
    private let round1Label = UILabel()
    private let round2Label = UILabel()
    private let round3Label = UILabel()
    private let round4Label = UILabel()
    private let round5Label = UILabel()
    
    private var labelsStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        self.backgroundColor = .init(red: 171/255, green: 237/255, blue: 216/255, alpha: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        nameLable.font = .boldSystemFont(ofSize: 16)
        
        gameResultLable.font = .systemFont(ofSize: 14)
        gameResultLable.textColor = .gray
        
        round1Label.font = .systemFont(ofSize: 14)
        round1Label.textColor = .gray
        
        round2Label.font = .systemFont(ofSize: 14)
        round2Label.textColor = .gray
        
        round3Label.font = .systemFont(ofSize: 14)
        round3Label.textColor = .gray
        
        round4Label.font = .systemFont(ofSize: 14)
        round4Label.textColor = .gray
        round4Label.text = "Раунд 4: не состоялся"
        
        round5Label.font = .systemFont(ofSize: 14)
        round5Label.textColor = .gray
        round5Label.text = "Раунд 5: не состоялся"
        
        labelsStackView = UIStackView(arrangedSubviews: [nameLable,
                                                         gameResultLable,
                                                         round1Label,
                                                         round2Label,
                                                         round3Label,
                                                         round4Label,
                                                         round5Label])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 5
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(labelsStackView)
        
        NSLayoutConstraint.activate([
            labelsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
    }
    
    
    func setupCell(array: Base.GameInfo) {
        nameLable.text = "Имя: " + array.name
        gameResultLable.text = "Результат игры: " + array.gameResult
        
        if array.roundsArray.count == 4 {
            round4Label.text = "Раунд 4: " + array.roundsArray[3]
        } else if array.roundsArray.count == 5 {
            round4Label.text = "Раунд 4: " + array.roundsArray[3]
            round5Label.text = "Раунд 5: " + array.roundsArray[4]
        }
        
        round1Label.text = "Раунд 1: " + array.roundsArray[0]
        round2Label.text = "Раунд 2: " + array.roundsArray[1]
        round3Label.text = "Раунд 3: " + array.roundsArray[2]
        
        

        
        switch array.gameResult {
        case "win":
            gameResultLable.textColor = .systemGreen
        case "lose":
            gameResultLable.textColor = .red
        default:
            gameResultLable.textColor = .gray
        }
        
    }
}
