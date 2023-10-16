//
//  GameViewController.swift
//  TestTask-22Byte
//
//  Created by Nikolai  on 15.10.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: - UI
    var robotImageView = UIImageView(image: UIImage(named: "icons8-futurama-bender-300(@3×)"))
    var robotButton = UIButton()
    var statusLabel = UILabel()
    var rockButton = UIButton()
    var paperButton = UIButton()
    var scissorsButton = UIButton()
    var nextRoundButton = UIButton()
    var restartGameButton = UIButton()
    
    var winLabel = UILabel()
    var loseLabel = UILabel()
    var drawLabel = UILabel()
    
    var winRoundsCountLabel = UILabel()
    var loseRoundsCountLabel = UILabel()
    var drawRoundsCountLabel = UILabel()
    
    //MARK: - variables
    var playerName = ""
    var gameResult = ""
    var winCountInGame = 0
    var roundArray = [GameState]()
    var roundStringArray = [String]()
    
    var winRoundsCount = 0
    var loseRoundsCount = 0
    var drawRoundsCount = 0
    var timeDelay = 0.6
    
    var countOfRounds = 0
    var localDrawCount = 0
    var signArray: [Sign] = [.rock, .scissors, .paper]
    var sortedSignArray = [Sign]()
    let defaults = UserDefaults.standard
    
    var firstRoundDrawSign: Sign = .rock //дефолтное значение
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        
        nextRoundButton.isHidden = true
        restartGameButton.isHidden = true
        robotButton.isHidden = true
    }
    
    //MARK: - Результаты раунда
    func playRound(_ sign: Sign) -> (GameState, Sign) {
        var result: GameState = .draw //дефолт
        var computerSign: Sign = .rock //дефолт
        
        if localDrawCount == 1 {
            let tuple = playDrawAgain(firstRoundDrawSign, sign)
            result = tuple.0
            computerSign = tuple.1
        } else {
            //генерируем случайную карту для робота
            computerSign = randomSign()
            result = sign.takeTurn(computerSign)
        }
        switch result {
        case .win:
            winRoundsCount += 1
            print("switch win")
        case .lose:
            loseRoundsCount += 1
            print("switch lose")
        case .draw:
            timeDelay = 1
            if localDrawCount == 1 {
                drawRoundsCount += 1
            }
            print("switch draw")
        }
        
        return (result, computerSign)
    }
    
    //MARK: - Ничья с двумя картами
    func playDrawAgain(_ firstRoundSign: Sign, _ currentRoundSign: Sign) -> (GameState, Sign){
        print("local count drow: \(localDrawCount)")
        let randonNumber = Int.random(in: 0...1)
        
        print("first draw sign in Play2 = \(firstRoundSign)")
        
        switch firstRoundSign {
        case .rock:
            sortedSignArray = signArray.filter { $0 != firstRoundSign} //создаем массив карт для робота, но без прошлой карты
            print(sortedSignArray)
        case .paper:
            sortedSignArray = signArray.filter { $0 != firstRoundSign }
            print(sortedSignArray)
        case .scissors:
            sortedSignArray = signArray.filter { $0 != firstRoundSign }
            print(sortedSignArray)
            
        }
        let computerSign = sortedSignArray[randonNumber]
        
        let result = currentRoundSign.takeTurn(computerSign)
        print(result)
        print("comp sign in play2 = \(computerSign)")
        print("my sign in play 2 = \(currentRoundSign)")
        return (result, computerSign)
    }
    
    func drawFinalGame() {
        statusLabel.backgroundColor = .darkGray
        statusLabel.text = " НИЧЬЯ в Игре! "
        
        nextRoundButton.isHidden = true
        restartGameButton.isHidden = false
        gameResult = "draw"
    }
    
    //MARK: - Переход к следующему раунду
    func nextRound() {
        statusLabel.text = "Камень, Ножницы, Бумага?"
        self.view.backgroundColor = UIColor.white
        statusLabel.backgroundColor = .white
        statusLabel.textColor = .black
        
        robotButton.setTitle("", for: .normal)
        robotButton.setImage(nil, for: .normal)
        
        rockButton.isHidden = true
        robotButton.alpha = 0
        
        rockButton.isHidden = false
        paperButton.isHidden = false
        scissorsButton.isHidden = false
        nextRoundButton.isHidden = false
        
        nextRoundButton.isHidden = true
        localDrawCount = 0
        
        timeDelay = 0.6
    }
    
    //MARK: - Перезапуск игры
    
    func restartGame() {
        statusLabel.text = "Камень, Ножницы, Бумага?"
        self.view.backgroundColor = UIColor.white
        statusLabel.backgroundColor = .white
        statusLabel.textColor = .black
        
        robotButton.isHidden = true
        robotButton.setImage(nil, for: .normal)
        
        rockButton.isHidden = false
        paperButton.isHidden = false
        scissorsButton.isHidden = false
        
        nextRoundButton.isHidden = true
        restartGameButton.isHidden = true
        
        winRoundsCount = 0
        loseRoundsCount = 0
        drawRoundsCount = 0
        countOfRounds = 0
        localDrawCount = 0
        
        winRoundsCountLabel.text = String(winRoundsCount)
        loseRoundsCountLabel.text = String(loseRoundsCount)
        drawRoundsCountLabel.text = String(drawRoundsCount)
        
        timeDelay = 0.6
    }
    
    //MARK: - Селекторы
    
    @objc func rockButtonPressed() {
        startRound(.rock, rockButton)
    }
    
    @objc func paperButtonPressed() {
        
        startRound(.paper, paperButton)
    }
    
    @objc func scissorsButtonPressed() {
        startRound(.scissors, scissorsButton)
    }
    
    @objc func resetButtonPressed() {
        nextRound()
    }
    
    @objc func restartGameButtonPressed() {
        print("ArrayRestart = \(roundArray)")
        roundStringArray = arrayToStringArray(roundArray)
        print("ArrayStringRestart = \(roundStringArray)")
        
//        Base.shared.saveGamesInfo(name: playerName, gameResult: gameResult)
        Base.shared.saveGamesInfo(name: playerName, gameResult: gameResult, roundsArray: roundStringArray)
        
        
        roundArray = []
        roundStringArray = []
        winCountInGame = 0
        restartGame()
    }
    
    func arrayToStringArray(_ array: [GameState]) -> [String]{
        var stringArray = [String]()
        
        for round in array {
            switch round {
            case .win:
                stringArray.append("win")
            case .lose:
                stringArray.append("lose")
            case .draw:
                stringArray.append("draw")
            }
        }
        return stringArray
    }
    
    //MARK: - Methods
    func startRound(_ sign: Sign, _ button: UIButton) {
        let tuple = playRound(sign)
        
        DispatchQueue.main.async {
            self.moveButton(button)
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + self.timeDelay) {
                self.resultOfRound(tuple.0, tuple.1)
            }
        }
    }
    
    func moveButton(_ button: UIButton) {
        let localCenter = button.center
        
        UIView.animate(withDuration: 0.5,
                       animations: {
            button.center.x = self.view.center.x
            button.center.y = button.center.y - (button.frame.height) / 2
            button.transform = CGAffineTransform.init(scaleX: 0.75, y: 0.75)
            
            self.robotButton.isHidden = false
            self.robotButton.center.y = self.robotButton.center.y + (button.frame.height) / 2
            
            self.robotButton.alpha = 1
        },completion: { _ in
            UIView.animate(withDuration: 0.5) {
                button.transform = CGAffineTransform.identity
                button.center.x = localCenter.x
                button.center.y = localCenter.y
                
                self.robotButton.center.y = self.robotButton.center.y - (button.frame.height) / 2
            }
        })
    }
    
    func resultOfRound (_ result: GameState, _ computerSign: Sign) {
        
        switch computerSign {
        case .rock:
            robotButton.setImage(UIImage(named: "icons8-rock-100"), for: .normal)
        case .paper:
            robotButton.setImage(UIImage(named: "icons8-paper-100"), for: .normal)
        case .scissors:
            robotButton.setImage(UIImage(named: "icons8-barber-scissors-100"), for: .normal)
        }
        
        switch result {
        case .win:
            statusLabel.text = " Ты выиграл раунд! "
            winRoundsCountLabel.text = String(winRoundsCount)
            statusLabel.backgroundColor = .systemGreen
            
            //MARK: Три победы у игрока
            if winRoundsCount == 3 {
                view.backgroundColor = .systemGreen
                nextRoundButton.isHidden = true
                restartGameButton.isHidden = false
                
                statusLabel.text = " Ты победил в игре! "
                //для userDefaults
                gameResult = "win"
                winCountInGame += 1
                
                countOfRounds += 1
                roundArray.append(result)
                return
            }
            
        case .lose:
            statusLabel.text = " Ты проиграл раунд "
            loseRoundsCountLabel.text = String(loseRoundsCount)
            statusLabel.backgroundColor = .red
            
            //MARK: Три победы у робота
            if loseRoundsCount == 3 {
                view.backgroundColor = .red
                nextRoundButton.isHidden = true
                restartGameButton.isHidden = false
                
                statusLabel.text = " Ты проиграл игру! "
                //для userDefaults
                gameResult = "lose"
                
                countOfRounds += 1
                roundArray.append(result)
                return
            }
        case .draw:
            if localDrawCount == 0 {
                statusLabel.text = " Ничья! Попробуй еще раз "
                statusLabel.backgroundColor = .lightGray
                statusLabel.textColor = .white
                
                nextRoundButton.isHidden = true
                localDrawCount += 1
                
                switch computerSign {
                case .rock:
                    rockButton.isHidden = true
                    paperButton.isHidden = false
                    scissorsButton.isHidden = false
                case .paper:
                    rockButton.isHidden = false
                    paperButton.isHidden = true
                    scissorsButton.isHidden = false
                case .scissors:
                    rockButton.isHidden = false
                    paperButton.isHidden = false
                    scissorsButton.isHidden = true
                }
                
                firstRoundDrawSign = computerSign
                print("first drow sign in move robot = \(firstRoundDrawSign)")
                
                return
            } else {
                statusLabel.text = " Ничья в раунде "
                statusLabel.backgroundColor = .darkGray
                localDrawCount = 0
                print("zero local draw count = \(localDrawCount)")
                drawRoundsCountLabel.text = String(drawRoundsCount)
            }
            
            //MARK: три ничьи в 5 раундах. НИЧЬЯ
            if drawRoundsCount == 3 {
                drawFinalGame()
            }
        }
        
        countOfRounds += 1
        roundArray.append(result)
        print("Array = \(roundArray)")
        
        //MARK: за 5 раундов никто не выиграл. НИЧЬЯ
        if countOfRounds == 5 {
            print("5 раундов")
            drawFinalGame()
        }
        
        //показываем кнопку сл раунда
        nextRoundButton.isHidden = false
    }
}

