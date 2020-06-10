//
//  Team.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-05.
//  Copyright © 2020 user169300. All rights reserved.
//

import Foundation

struct Teams {
    var results: [Team]
}

struct Team {
    var name: String
    var createdAt: Date
    var isArchive: Bool
    var updatedAt: Date
    var pokemonName1: String
    var pokemonName2: String?
    var pokemonName3: String?
    var pokemonName4: String?
    var pokemonName5: String?
    var pokemonName6: String?
}
