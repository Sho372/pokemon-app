//
//  SelectPokemonTableViewController.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-11.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit

class SelectPokemonTableViewController: UITableViewController {
    
    // MARK: - Dependency Injection
    var selectedPokemon: String?
    
    // MARK: - Identifier
    private struct Identifier {
        static let cell = "SelectPokemonCell"
    }
    
    private var pokedex = PokeDex()
    private let str = NSCharacterSet.capitalizedLetters
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Select Pokemon"
        
        PokeAPIHandler.shared.requestJSON { [weak self] (pokemons) in
            print("Fetch start")
            if let pokemons = pokemons {
                
                let pokemonList = pokemons.results.map({ $0.name.capitalized })
                let groupedDictionary = Dictionary(grouping: pokemonList, by: { String($0.prefix(1))})
                let keys = groupedDictionary.keys.sorted()
                self?.pokedex.section = keys.map { Section(letter: $0, pokemons: groupedDictionary[$0]!.sorted()) }
                
                print("Fetch done")
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokedex.section[section].pokemons?.count ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 26
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.cell, for: indexPath)
        cell.textLabel?.text = pokedex.section[indexPath.section].pokemons?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        tableView.deselectRow(at: indexPath, animated: true)
        selectedPokemon = pokedex.section[indexPath.section].pokemons?[indexPath.row]
    }
    
    
}
