//
//  SelectPokemonTableViewController.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-11.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit

protocol SelectPokemonTableViewControllerDelegate: class {
    func didSelect(selectedPokemon: String)
}

class SelectPokemonTableViewController: UITableViewController {
    
    // MARK: - Dependency Injection
    var selectedPokemon: String?
    
    // MARK: - Identifier
    private struct Identifier {
        static let cell = "SelectPokemonCell"
    }
    
    // MARK: - Delegate
    weak var delegate: SelectPokemonTableViewControllerDelegate?
    
    private var pokedex = PokeDex()
    private var keys = [String]()
    private let str = NSCharacterSet.capitalizedLetters
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Select Pokemon"
        
        PokeAPIHandler.shared.requestJSON { [weak self] (pokemons) in
            debugPrint("JSON Requested")
            if let pokemons = pokemons {
                let pokemonList = pokemons.results.map({ $0.name.capitalized })
                let groupedDictionary = Dictionary(grouping: pokemonList, by: { String($0.prefix(1))})
                let keys = groupedDictionary.keys.sorted()
                self?.keys = keys
                self?.pokedex.section = keys.map { Section(letter: $0, pokemons: groupedDictionary[$0]!.sorted()) }
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keys[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.cell, for: indexPath)
        cell.textLabel?.text = pokedex.section[indexPath.section].pokemons?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(selectedPokemon: pokedex.section[indexPath.section].pokemons?[indexPath.row] ?? "Not Set")
        navigationController?.popViewController(animated: true)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keys
    }
}
