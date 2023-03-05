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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        print(pokemons)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
