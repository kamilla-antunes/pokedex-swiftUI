//
//  ContentView.swift
//  Pokedex
//
//  Created by Kamilla Mylena Teixeira Antunes on 29/08/22.
//

import SwiftUI
import Kingfisher

struct PokemonView: View {
    @ObservedObject var pokemonVM = PokemonViewModel()
    
    var body: some View {
        NavigationView {
            List(pokemonVM.pokemon) { poke in
                NavigationLink(destination: PokemonDetailView(pokemon: poke)) {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(poke.name.capitalized)
                                .font(.title)
                            HStack {
                                Text(poke.type.capitalized)
                                    .italic()
                                Circle()
                                    .foregroundColor(poke.typeColor)
                                    .frame(width: 10, height: 10)
                            }
                            Text(poke.description)
                                .font(.caption)
                                .lineLimit(2)
                        }
                        
                        Spacer()
                        
                        KFImage(URL(string: poke.imageURL))
                            .interpolation(.none)
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                }
            }
            .navigationTitle("Pokemon")
        }
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView()
    }
}
