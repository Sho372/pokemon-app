//
//  ManagedTeam.swift
//  pokemon-app
//
//  Created by user169300 on 6/8/20.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit
import CoreData

class ManagedTeam: NSManagedObject {
    class func findOrCreateTeam(matching teamInfo: Team, in context: NSManagedObjectContext) throws -> ManagedTeam {

        let request: NSFetchRequest<ManagedTeam> = ManagedTeam.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", teamInfo.name)
        do {
          let matches = try context.fetch(request)
          if matches.count > 0 {
            assert(matches.count == 1, "ManagedTeam.findOrCreateTeam -- database inconsistency")
            let matchedTeam = matches[0]
            return matchedTeam
          }
        } catch {
          throw error
        }
        
        // no match
        let team = ManagedTeam(context: context)
        team.name = teamInfo.name
        team.pokemonName1 = teamInfo.pokemonName1
        team.pokemonName2 = teamInfo.pokemonName2
        team.pokemonName3 = teamInfo.pokemonName3
        team.pokemonName4 = teamInfo.pokemonName4
        team.pokemonName5 = teamInfo.pokemonName5
        team.pokemonName6 = teamInfo.pokemonName6
        team.isArchive = teamInfo.isArchive
        team.createdAt = teamInfo.createdAt
        team.updatedAt = teamInfo.updatedAt
        return team
    }
    
    /// Get count of entities of Team
    /// - Parameters:
    ///   - in: context
    /// - Returns: count of entities of Team
    class func count(in context: NSManagedObjectContext) -> Int{
        let request: NSFetchRequest<ManagedTeam> = ManagedTeam.fetchRequest()
        
        do {
            let count = try context.count(for: request)
            return count
        } catch _ as NSError {
            return 0
        }
    }
    
    /// Get all entities of Team
    /// - Parameters:
    ///   - in: context
    /// - Returns: Array of ManagedTeam
    class func fetchAll(in context: NSManagedObjectContext) -> [ManagedTeam] {
        let request: NSFetchRequest<ManagedTeam> = ManagedTeam.fetchRequest()
        
        do {
            let teams = try context.fetch(request)
            return teams
        } catch {
            print("error")
        }
        return []
    }
}
