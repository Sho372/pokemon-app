//
//  Pokemon.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-01.
//  Copyright © 2020 user169300. All rights reserved.
//

import Foundation

struct Pokemons: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable {
    let name: String
}


