//
//  Sign.swift
//  TestTask-22Byte
//
//  Created by Nikolai  on 15.10.2023.
//

import Foundation
import GameplayKit

let randomChoice = GKRandomDistribution(lowestValue: 0, highestValue: 2)
//let randomChoice = Int.random(in: 0...2)

func randomSign() -> Sign {
    
    let sign = randomChoice.nextInt()

    switch sign {
    case 1:
        return .rock
    case 2:
        return .paper
    default:
        return .scissors
    }
}

enum Sign {
    case rock, paper, scissors
    
    var emoji: String {
        switch self {
        case .paper:
            return "👋"
        case .rock:
            return "👊"
        case .scissors:
            return "✌️"
        }
    }
    
    func takeTurn(_ oposite: Sign) -> GameState {
        switch (self, oposite) {
        case (.rock, .rock),
             (.paper, .paper),
             (.scissors, .scissors):
            return .draw
        case (.rock, .scissors),
             (.paper, .rock),
             (.scissors, .paper):
            return .win
        default:
            return .lose
        }
    }
}
