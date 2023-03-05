//
//  ViewController.swift
//  who is that pokemon
//
//  Created by Alex Camacho on 01/08/22.
//

import UIKit
import Kingfisher

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet var answerButtons: [UIButton]!
    
    lazy private var pokemonManager = PokemonManager()
    lazy private var imageManager = ImageManager()
    lazy private var game = GameModel()
    
    var randomPokemons : [PokemonModel] = [] {
        didSet {
            setButtonsTitle()
        }
    }
    var correctAnswer : String = ""
    var correctAnswerImage : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pokemonManager.delegate = self
        self.imageManager.delegate = self
        self.messageLabel.text = ""
        self.createButtons()
        pokemonManager.fetchData()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let userAnswer = sender.title(for: .normal)!
        if game.verifyAnswer(verify: userAnswer, with: correctAnswer) {
            self.messageLabel.text = "Si, es un \(userAnswer)"
            self.scoreLabel.text = "Puntaje: \(game.getScore())"
            
            sender.layer.borderColor = UIColor.systemGreen.cgColor
            sender.layer.borderWidth = 2.0
            
            let url = URL(string: self.correctAnswerImage)
            self.pokemonImage.kf.setImage(with: url)
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { timer in
                self.pokemonManager.fetchData()
                self.messageLabel.text = ""
                sender.layer.borderWidth = 0.0
            }
        } else {
            self.game.resetScore()
            self.messageLabel.text = "No, es un \(correctAnswer)"
            self.scoreLabel.text = "Puntaje: \(game.getScore())"
            
            sender.layer.borderColor = UIColor.systemRed.cgColor
            sender.layer.borderWidth = 2.0
            
            let url = URL(string: self.correctAnswerImage)
            self.pokemonImage.kf.setImage(with: url)
            
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { timer in
                self.pokemonManager.fetchData()
                self.messageLabel.text = ""
                sender.layer.borderWidth = 0.0
            }
        }
    }
    
    func createButtons() {
        for button in self.answerButtons {
            button.layer.cornerRadius = 10.0
        }
    }
    
    func setButtonsTitle() {
        for(index, button) in answerButtons.enumerated() {
            DispatchQueue.main.async {
                button.setTitle(self.randomPokemons[safe: index]?.name.capitalized, for: .normal)
            }
        }
    }
}

extension PokemonViewController : PokemonManagerDelegate {
    func didUpdatePokemon(pokemons: [PokemonModel]) {
        self.randomPokemons = pokemons.choose(4)
        let idx = Int.random(in: 0...3)
        let imageData = self.randomPokemons[idx].imageURL
        self.correctAnswer = self.randomPokemons[idx].name
        self.imageManager.fetchImage(url: imageData)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension PokemonViewController : ImageManagerDelegate {
    func didUpdateImage(image: ImageModel) {
        self.correctAnswerImage = image.imageURL
        
        DispatchQueue.main.async { [self] in
            let url = URL(string: image.imageURL)
            let effect = ColorControlsProcessor(brightness: -1, contrast: 1, saturation: 1, inputEV: 0)
            pokemonImage.kf.setImage(with: url, options: [.processor(effect)])
        }
    }
    func didFailWithImageError(error: Error) {
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
