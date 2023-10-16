//
//  Base.swift
//  TestTask-22Byte
//
//  Created by Nikolai  on 16.10.2023.
//

import Foundation

class Base {
    
    let defaults = UserDefaults.standard
    
    static let shared = Base()
    
    struct GameInfo: Codable {
        var name: String
        var gameResult: String
        var roundsArray: [String]
    }
    
    var allGamesInfo: [GameInfo] {
        
        get {
            if let data = defaults.value(forKey: "allGamesInfo") as? Data {
                return try! PropertyListDecoder().decode([GameInfo].self, from: data)
            } else {
                return [GameInfo]()
            }
        }
        
        set {
            
            if let data = try? PropertyListEncoder().encode(newValue){
                defaults.set(data, forKey: "allGamesInfo")
            }
            
        }
        
    }
    
    func saveGamesInfo(name: String, gameResult: String, roundsArray: [String]) {
        let gameInfo = GameInfo(name: name, gameResult: gameResult, roundsArray: roundsArray)
        allGamesInfo.insert(gameInfo, at: 0)
    }
    
}
