//
//  ManagedSelectedPokemon.swift
//  pokemon-app
//
//  Created by user169300 on 6/10/20.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit
import CoreData

class ManagedSelectedPokemons: NSManagedObject {
    
    class func createSelectedPokemon(sequence seq: Int16, selectedPokemonName name: String?, in context: NSManagedObjectContext) throws -> ManagedSelectedPokemons {
        let selected = ManagedSelectedPokemons(context: context)
        selected.sequence = seq
        selected.selectedPokemonName = name
        return selected
    }

}
