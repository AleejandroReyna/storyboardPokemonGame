//
//  ResultsViewController.swift
//  who is that pokemon
//
//  Created by Alejandro Reyna on 5/03/23.
//

import UIKit
import Kingfisher

class ResultsViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    var pokemonName : String = ""
    var pokemonImageURL : String = ""
    var finalScore : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Perdiste, tu puntaje fue de \(self.finalScore)."
        pokemonLabel.text = "No, es \(pokemonName)"
        pokemonImage.kf.setImage(with: URL(string: pokemonImageURL))

        // Do any additional setup after loading the view.
    }
    
    @IBAction func playAgainPress(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */

}
