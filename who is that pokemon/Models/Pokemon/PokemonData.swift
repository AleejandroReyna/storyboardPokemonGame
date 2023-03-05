//
//  PokemonData.swift
//  who is that pokemon
//
//  Created by Alejandro Reyna on 4/03/23.
//

import Foundation

struct PokemonData : Codable {
    let results : [Result]?
}

struct Result : Codable {
    let name : String?
    let url : String?
}

