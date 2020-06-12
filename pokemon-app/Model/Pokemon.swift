//
//  Pokemon.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-01.
//  Copyright © 2020 user169300. All rights reserved.
//

import Foundation

class Pokemons: Codable {
    let count: Int
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
}


