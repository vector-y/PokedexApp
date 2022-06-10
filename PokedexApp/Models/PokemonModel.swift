//
//  PokemonModel.swift
//  PokedexApp
//
//  Created by Victor Tran on 6/9/22.
//

import Foundation
import SwiftUI

struct PokemonPage: Codable {
    let count: Int
    let next: String
    let results: [Pokemon]
}

// equatable allows for comparison if needed
// struct is based on the json file data, first struct = ID, each following struct has name & url for each pokemon
struct Pokemon: Codable, Identifiable, Equatable {
    let id = UUID()
    let name: String
    let url: String
    
    static var samplePokemon = Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/" )
}

struct DetailPokemon: Codable {
    let id: Int
    let height: Int
    let weight: Int
}
