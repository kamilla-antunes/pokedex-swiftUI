//
//  StatsViewGroup.swift
//  Pokedex
//
//  Created by Kamilla Mylena Teixeira Antunes on 30/08/22.
//

import SwiftUI

struct StatsViewGroup: View {
    var pokemon: Pokemon
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 300, height: 250)
                .foregroundColor(.white)
                .opacity(0.6)
                .cornerRadius(20)
            
            VStack(alignment: .leading, spacing: 30) {
                StatView(pokemon: pokemon, statName: "Atk", statColor: .blue, statValue: pokemon.attack)
                StatView(pokemon: pokemon, statName: "Def", statColor: .red, statValue: pokemon.defense)
                StatView(pokemon: pokemon, statName: "Hgt", statColor: .purple, statValue: pokemon.height)
                StatView(pokemon: pokemon, statName: "Wgt", statColor: .green, statValue: pokemon.weight)
            }
        }
    }
}

struct StatsViewGroup_Previews: PreviewProvider {
    static var previews: some View {
        StatsViewGroup(pokemon: PokemonViewModel().MOCK_POKEMON)
    }
}
