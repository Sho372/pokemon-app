//
//  ManagedHistory.swift
//  pokemon-app
//
//  Created by user169300 on 6/10/20.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit
import CoreData

class ManagedHistory: NSManagedObject {
    class func createHistory(history historyInfo: History,
                             selectedPokemons selectedInfo: [ManagedSelectedPokemons?],
                             opponentPokemons opponentInfo: [ManagedOpponentPokemons?], in context: NSManagedObjectContext) throws -> ManagedHistory {
        let history = ManagedHistory(context: context)
        history.teamName = historyInfo.teamName
        history.isWin = historyInfo.isWin
        history.isSingle = historyInfo.isSingle
        history.createdAt = historyInfo.createdAt
        history.updatedAt = historyInfo.updatedAt
        history.selectedPokemons = NSSet.init(array: selectedInfo)
        history.opponentPokemons = NSSet.init(array: opponentInfo)
        return history
    }
    
    /// Get all entities of Pokemon
    /// - Parameters:
    ///   - in: context
    /// - Returns: Array of ManagedPokemon
    class func fetchAll(in context: NSManagedObjectContext) -> [ManagedHistory] {
        let request: NSFetchRequest<ManagedHistory> = ManagedHistory.fetchRequest()
        
        do {
            let histories = try context.fetch(request)
            return histories
        } catch {
            print("error")
        }
        return []
    }
    
    class func fetchWithObjectId(objectId: NSManagedObjectID, in context: NSManagedObjectContext) throws -> ManagedHistory? {
        if let history = try? context.existingObject(with: objectId) {
            return history as? ManagedHistory
        }
        return nil
    }
}
