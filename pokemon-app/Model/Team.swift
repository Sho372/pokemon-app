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
    let name: String
    let createdAt: Date
    let isArchive: Bool
    let updatedAt: Date
    let pokemonName1: String
    let pokemonName2: String?
    let pokemonName3: String?
    let pokemonName4: String?
    let pokemonName5: String?
    let pokemonName6: String?
}
