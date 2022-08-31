//
//  PokemonNetworkManager.swift
//  Pokedex
//
//  Created by Kamilla Mylena Teixeira Antunes on 29/08/22.
//

import Foundation

class PokemonViewModel: ObservableObject {
    
    @Published var pokemon = [Pokemon]()
    
    init() {
        Task {
            pokemon = try await getPokemon()
        }
    }
    
    let urlRequisition = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    let MOCK_POKEMON = Pokemon(id: 0,
                               name: "Squirtle",
                               imageURL: "https://firebasestorage.googleapis.com/v0/b/pokedex-bb36f.appspot.com/o/pokemon_images%2FF0F9F418-BC72-40B8-BE22-F401D506185B?alt=media&token=2cee6cce-2256-43ad-a824-d97b8a646d37",
                               type: "water",
                               description: "This is a test example of what the text in the description would look like for the given pokemon. This is a test example of what the text in the description would look like for the given pokemon.",
                               attack: 49,
                               defense: 52,
                               height: 10,
                               weight: 98)
    
    func getPokemon() async throws -> [Pokemon] {
        guard let url = URL(string: urlRequisition) else { throw FetchError.badURL }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.badResponse }
        guard let data = data.removeNullsFrom(string: "null,") else { throw FetchError.badData }
        
        let maybePokemonData = try JSONDecoder().decode([Pokemon].self, from: data)
        
        return maybePokemonData
    }
}

enum FetchError: Error {
    case badURL
    case badResponse
    case badData
}

extension Data {
    func removeNullsFrom(string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: " ")
        
        guard let data = parsedDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
