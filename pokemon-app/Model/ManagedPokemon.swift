//
//  ManagedPokemon.swift
//  pokemon-app
//
//  Created by user169300 on 6/3/20.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit
import CoreData

class ManagedPokemon: NSManagedObject {
    class func findOrCreatePokemon(matching pokemonInfo: Pokemon, in context: NSManagedObjectContext) throws -> ManagedPokemon {
        let request: NSFetchRequest<ManagedPokemon> = ManagedPokemon.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", pokemonInfo.name)
        do {
          let matches = try context.fetch(request)
          if matches.count > 0 {
            assert(matches.count == 1, "ManagedPokemon.findOrCreatePokemon -- database inconsistency")
            let matchedPokemon = matches[0]
            return matchedPokemon
          }
        } catch {
          throw error
        }
        
        // no match
        let pokemon = ManagedPokemon(context: context)
        pokemon.name = pokemonInfo.name
        return pokemon
    }
    
    class func count(in context: NSManagedObjectContext) -> Int{
        let request: NSFetchRequest<ManagedPokemon> = ManagedPokemon.fetchRequest()
        
        do {
            let count = try context.count(for: request)
            return count
        } catch _ as NSError {
            return 0
        }
    }
}
