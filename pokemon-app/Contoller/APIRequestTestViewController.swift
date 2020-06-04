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
            self.printDatabaseStatistics()
        }
        
    }
    
    private func printDatabaseStatistics(){
        let context = container?.viewContext
        if let pokemonCount = (try? context?.fetch(ManagedPokemon.fetchRequest()))?.count{
            print("\(pokemonCount) pokemons")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
