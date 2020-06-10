//
//  APIRequestTestViewController.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-01.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit
import CoreData

class APIRequestTestViewController: UIViewController {
    
//    private var networkAPI: PokeAPIRequest!
    
    private var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        networkAPI = PokeAPIRequest.shared
    }
    
    @IBAction func pokeAPIRequestTest(_ sender: UIButton) {
        PokeAPIRequest.shared.getPokemonNames { (pokemons) in
            if let pokemons = pokemons?.results {
                print(pokemons.map { $0.name })
                // local caching with CoreData
                self.updateDatabase(with: pokemons)
                
            }
        }
    }
    
    private func updateDatabase(with pokemons: [Pokemon]){
        container?.performBackgroundTask{ context in
            for pokemon in pokemons {
                _ = try? ManagedPokemon.findOrCreatePokemon(matching: pokemon, in: context)
            }
            try? context.save()
            let firstTeam = Team(name: "first team", createdAt: Date(), isArchive: false, updatedAt: Date(), pokemonName1: "aaa", pokemonName2: "bbb", pokemonName3: "ccc", pokemonName4: "ddd", pokemonName5: "eee", pokemonName6: "fff"
            )
            let secondTeam = Team(name: "second team", createdAt: Date(), isArchive: false, updatedAt: Date(), pokemonName1: "aaa", pokemonName2: "bbb", pokemonName3: "ccc", pokemonName4: "ddd", pokemonName5: "eee", pokemonName6: "fff"
            )
            try? ManagedTeam.findOrCreateTeam(matching: firstTeam, in: context)
            try? ManagedTeam.findOrCreateTeam(matching: secondTeam, in: context)
            try? context.save()

            let count = ManagedTeam.count(in: context)
                print("\(count)teams" )
            let teams = ManagedTeam.fetchAll(in: context)
            for team in teams {
                print(team.name)
                print(team.pokemonName1)
                print(team.createdAt)
            }
        }
    }
}
