//
//  Request.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-01.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit
import Foundation

class PokeAPIRequest {
    
    // Singleton
    static let shared = PokeAPIRequest()
    
    private var dataTask: URLSessionDataTask?
    
    private init() {}
    
    func getPokemonNames(completion: @escaping (Pokemons?) -> Void) {
        let url = URL(string: EndPoint.baseURL)!
            .appendingPathComponent("pokemon")
            .withQueries([Parameter.limit: "1000"])!
        
        fetch(from: url) { (result: Result<Pokemons, NetworkError>) in
            switch result {
            case.success(let pokemons):
                completion(pokemons)
            case.failure(let error):
                debugPrint(error.errorDescription!)
                completion(nil)
            }
        }
    }
    
    func fetch<T: Decodable>(from url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        dataTask?.cancel()
        
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
        dataTask?.resume()
    }
    
    struct EndPoint {
        static let baseURL = "https://pokeapi.co/api/v2/"
    }
    
    struct Parameter {
        static let pokemon = "pokemon"
        static let limit = "limit"
    }
    
    enum NetworkError: Error {
        case client(message: String)
        case server
    }
    
}

extension PokeAPIRequest.NetworkError: LocalizedError {
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
