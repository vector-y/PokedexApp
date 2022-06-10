//
//  ViewModel.swift
//  PokedexApp
//
//  Created by Victor Tran on 6/9/22.
//

import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    private let pokemonManager = PokemonManager()
    
    @Published var pokemonList = [Pokemon]()
    @Published var pokemonDetails: DetailPokemon?
    @Published var searchText = ""
    
    //computed property to help search for pokemon
    var filteredPokemon: [Pokemon] {
        return searchText == "" ? pokemonList : pokemonList.filter{
            $0.name.contains(searchText.lowercased())
        }
    }
    
    init() {
        self.pokemonList = pokemonManager.getPokemon()
        // print(self.pokemonList) // helps verify that the pokemon json file loads
    }
    
    func getPokemonID(pokemon: Pokemon) -> Int {
        if let index = self.pokemonList.firstIndex(of: pokemon){
            return index + 1
        }
        return 0 // if no pokemon is found, return 0
    }
    
    func getDetails(pokemon: Pokemon){
        let id = getPokemonID(pokemon: pokemon)
        
        self.pokemonDetails = DetailPokemon(id: 0, height: 0, weight: 0)
        
        // completion is passed in as a closure in the { } after id.
        pokemonManager.getDetailedPokemon(id: id) { data in
            
            DispatchQueue.main.async { //makes sure that this is updated on our main thread
                self.pokemonDetails = data
            }
        }
    }
    
    // formats our height and weight, might make more sense in the helper section
    func formatHW(value: Int) -> String {
        let dValue = Double(value)
        let string = String(format: "%.2f", dValue / 10)
        
        return string
    }
}
