//
//  ManagedOpponentPokemons.swift
//  pokemon-app
//
//  Created by user169300 on 6/10/20.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit
import CoreData

class ManagedOpponentPokemons: NSManagedObject {
    class func createOpponentPokemon(sequence seq: Int16, opponetPokemonName name: String?, isSelected selected: Bool, in context: NSManagedObjectContext) throws -> ManagedOpponentPokemons {
        let opponent = ManagedOpponentPokemons(context: context)
        opponent.sequence = seq
        opponent.opponentPokemonName = name
        opponent.isSelected = selected
        return opponent
    }
}
