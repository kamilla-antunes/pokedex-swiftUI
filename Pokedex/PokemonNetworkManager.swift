//
//  PokemonNetworkManager.swift
//  Pokedex
//
//  Created by Kamilla Mylena Teixeira Antunes on 29/08/22.
//

import Foundation

class PokemonNetworkManager {
    let urlRequisition = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
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
