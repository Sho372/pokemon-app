//
//  PokeAPIHandler.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-01.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit
import Foundation

class PokeAPIHandler {
    
    private static let baseURL = "https://pokeapi.co/api/v2/"
    
    private struct EndPoint {
        static let pokemon = "pokemon"
    }
    
    private struct Parameter {
        static let limit = "limit"
    }
    
    private struct Key {
        static let cachedPokemonNames: NSString = "CachedPokemonNames"
    }
    
    // Singleton
    static let shared = PokeAPIHandler()
    
    private var dataTask: URLSessionDataTask?
    
    private let cache = NSCache<NSString, Pokemons>()
    
    private init() {}
    
    func requestJSON(completion: @escaping (Pokemons?) -> Void) {
        if let cachedPokemons = cache.object(forKey: Key.cachedPokemonNames) {
            debugPrint("Cached Pokemon Used")
            completion(cachedPokemons)
        } else {
            let url = URL(string: PokeAPIHandler.baseURL)!
                .appendingPathComponent(EndPoint.pokemon)
                .withQueries([Parameter.limit: "1000"])!
            fetch(from: url) { (result: Result<Pokemons, NetworkError>) in
                switch result {
                case .success(let pokemons):
                    self.cache.setObject(pokemons, forKey: Key.cachedPokemonNames)
                    completion(pokemons)
                case .failure(let error):
                    debugPrint(error.errorDescription!)
                    completion(nil)
                }
            }
        }
    }
    
    func fetch<T: Decodable>(from url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        dataTask?.cancel()
        debugPrint("Fetch start")
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.client(message: "invalid request")))
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.server))
                return
            }
            do {
                guard let data = data else {
                    completion(.failure(.client(message: "data is nil")))
                    return
                }
                let decodable = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodable))
            } catch {
                completion(.failure(.client(message: error.localizedDescription)))
            }
        }
        debugPrint("Fetch done")
        dataTask?.resume()
    }
    
    enum NetworkError: Error {
        case client(message: String)
        case server
    }
    
}

extension PokeAPIHandler.NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .server:
            return NSLocalizedString(
                "Server error!",
                comment: ""
            )
        case .client(let message):
            return NSLocalizedString(
                "Client error! - \(message)",
                comment: ""
            )
        }
    }
}
