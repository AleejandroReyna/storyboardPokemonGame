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
        return self.score
    }
    
    private mutating func setScore (score : Int) -> Void {
        self.score = score
        
    }
    
    mutating func verifyAnswer(verify userAnswer : String, with correctAnswer : String) -> Bool {
        if checkAnswer(verify: userAnswer, with: correctAnswer) {
            self.setScore(score: self.score + 1)
            return true
        } else {
            return false
        }
    }
    
    mutating func resetScore() -> Void {
        self.setScore(score: 0)
    }
}
