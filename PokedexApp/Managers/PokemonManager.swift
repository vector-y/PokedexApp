//
//  PokemonManager.swift
//  PokedexApp
//
//  Created by Victor Tran on 6/9/22.
//

// Helps us retrieve the data from the ViewModel

import Foundation

class PokemonManager {
    // getPokemon returns an array of Pokemon to us
    func getPokemon() -> [Pokemon] {
        let data : PokemonPage = Bundle.main.decode(file: "pokemon.json")
        let pokemon: [Pokemon] = data.results
        
        return pokemon
    }
    
    func getDetailedPokemon(id: Int, _ completion: @escaping (DetailPokemon) -> ()) {
        Bundle.main.fetchData(url: "https://pokeapi.co/api/v2/pokemon/\(id)/", model: DetailPokemon.self) { data in
            completion(data)
        } failure: { error in
            print(error)
        }
    }
}
