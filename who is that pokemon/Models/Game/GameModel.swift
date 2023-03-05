//
//  GameModel.swift
//  who is that pokemon
//
//  Created by Alejandro Reyna on 4/03/23.
//

import Foundation

struct GameModel {
    var score : Int = 0
    
    private func checkAnswer(verify userAnswer : String, with correctAnswer : String) -> Bool {
        return userAnswer.lowercased() == correctAnswer.lowercased()
    }
    
    func getScore () -> Int {
        return score
    }
    
    private mutating func setScore (score : Int) -> Bool {
        self.score = score
        return true
        
    }
    
    mutating func verifyAnswer(verify userAnswer : String, with correctAnswer : String) -> Bool {
        return checkAnswer(verify: userAnswer, with: correctAnswer) ? setScore(score: self.score + 1) : false
    }
}
