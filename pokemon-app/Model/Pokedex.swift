//
//  Pokedex.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-11.
//  Copyright © 2020 user169300. All rights reserved.
//

import Foundation

class PokeDex {
    var section: [Section]
    
    init(with section: [Section]) {
        self.section = section
    }
    
    convenience init() {
        self.init(with: [Section]())
    }
}

struct Section {
    let letter: String
    var pokemons: [String]?
}
