//
//  ViewController.swift
//  who is that pokemon
//
//  Created by Alex Camacho on 01/08/22.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet var answerButtons: [UIButton]!
    
    lazy private var pokemonManager = PokemonManager()
    var randomPokemons : [PokemonModel] = []
    var correctAnswer : String = ""
    var correctAnswerImage : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pokemonManager.delegate = self
        self.createButtons()
        pokemonManager.fetchData()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        print(sender.title(for: .normal)!)
    }
    
    func createButtons() {
        for button in self.answerButtons {
            button.layer.cornerRadius = 10.0
        }
    }
}

extension PokemonViewController : PokemonManagerDelegate {
    func didUpdatePokemon(pokemons: [PokemonModel]) {
        self.randomPokemons = pokemons.choose(4)
        let idx = Int.random(in: 0...3)
        let imageData = self.randomPokemons[idx].imageURL
        self.correctAnswer = self.randomPokemons[idx].name
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

extension Collection where Indices.Iterator.Element == Index {
    public subscript(safe index : Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}

extension Collection {
    func choose(_ n : Int) -> [Element] {
        Array(shuffled().prefix(n))
    }
}
