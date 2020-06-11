//
//  SelectPokemonTableViewController.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-11.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit

protocol SelectPokemonTableViewControllerDelegate: class {
    func didSelect(name: String)
}

class SelectPokemonTableViewController: UITableViewController {

    private struct Identifier {
        static let cell = "reuseIdentifier"
    }
    
    weak var delegate: SelectPokemonTableViewControllerDelegate?
    
    private var pokemonList: [String]?
    
    var selectedPokemon: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Identifier.cell)
        navigationItem.title = "Select Pokemon"
        PokeAPIHandler.shared.requestJSON { [weak self] (pokemons) in
            if let pokemons = pokemons{
                self?.pokemonList = pokemons.results.map({ $0.name.capitalized }).sorted(by: <)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }  
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonList?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.cell, for: indexPath)
        cell.textLabel?.text = pokemonList?[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedPokemon = pokemonList?[indexPath.row]
        delegate?.didSelect(name: selectedPokemon!)
        tableView.reloadData()
    }


}
