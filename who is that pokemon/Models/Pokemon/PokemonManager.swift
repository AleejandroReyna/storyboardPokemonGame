//
//  PokemonManager.swift
//  who is that pokemon
//
//  Created by Alejandro Reyna on 4/03/23.
//

import Foundation

protocol PokemonManagerDelegate {
    func didUpdatePokemon(pokemons : [PokemonModel])
    func didFailWithError(error : Error)
}

struct PokemonManager {
    let pokemonURL : String = "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0"
    var delegate : PokemonManagerDelegate?
    
    func fetchData(){
        performRequest(with: pokemonURL)
    }
    
    
    private func performRequest(with uri : String) {
        if let url = URL(string : uri) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data , response ,err in
                if(err != nil) {
                    self.delegate?.didFailWithError(error: err!)
                }
                if let safeData = data {
                    if let pokemon = self.parseJSON(pokemonData: safeData) {
                        self.delegate?.didUpdatePokemon(pokemons: pokemon)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    private func parseJSON(pokemonData : Data) -> [PokemonModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(PokemonData.self, from: pokemonData)
            let pokemon = decodedData.results?.map{
                PokemonModel(name: $0.name ?? "", imageURL: $0.url ?? "")
                
            }
            return pokemon
        } catch {
            return nil
        }
    }
}
