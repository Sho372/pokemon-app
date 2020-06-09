//
//  Team.swift
//  pokemon-app
//
//  Created by user169300 on 6/4/20.
//  Copyright © 2020 user169300. All rights reserved.
//

import Foundation

struct Teams: Codable {
    let results: [Team]
}

struct Team: Codable {
    let createdAt: Date
    let isArchive: Bool
    let teamName: String
    let updatedAt: Date
    let pokemons: [Pokemon]
}
