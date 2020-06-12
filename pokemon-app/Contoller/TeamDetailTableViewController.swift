//
//  TeamDetailTableViewController.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-05.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit

class TeamDetailTableViewController: UITableViewController {
    
    // MARK: - Dependency Injection
    var team: Team?
    
    // MARK: - Storyboard Referencing Outlets
    @IBOutlet var teamNameTextField: UITextField!
    @IBOutlet var archiveSwitch: UISwitch!
    @IBOutlet var pokemonLabel1: UILabel!
    @IBOutlet var pokemonLabel2: UILabel!
    @IBOutlet var pokemonLabel3: UILabel!
    @IBOutlet var pokemonLabel4: UILabel!
    @IBOutlet var pokemonLabel5: UILabel!
    @IBOutlet var pokemonLabel6: UILabel!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    // MARK: - Identifier
    struct Identifier {
        static let select = "SelectPokemonSegue"
        static let unwindWithData = "UnwindWithDataSegue"
        static let unwindCancel = "UnwindCancelSegue"
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PokeAPIHandler.shared.requestJSON(completion: { _ in return })
        
        if let team = team {
            navigationItem.title = "Edit Team"
            teamNameTextField.text = team.name
            archiveSwitch.isOn = team.isArchive
            pokemonLabel1.text = team.pokemonName1
            pokemonLabel2.text = team.pokemonName2
            pokemonLabel3.text = team.pokemonName3
            pokemonLabel4.text = team.pokemonName4
            pokemonLabel5.text = team.pokemonName5
            pokemonLabel6.text = team.pokemonName6
        }
        validateData()
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        validateData()
    }
    
    @IBAction func returnKeyPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Identifier.unwindCancel, sender: self)
    }
    
    private func validateData() {
        saveButton.isEnabled = !(teamNameTextField?.text ?? "").isEmpty && pokemonLabel1.text != "Not Set"
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section) {
        case (2):
            performSegue(withIdentifier: Identifier.select, sender: self)
        default:
            break;
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Identifier.unwindWithData :
                let date = Date()
                team = Team(
                    name: teamNameTextField.text ?? "",
                    createdAt: team?.createdAt ?? date,
                    isArchive: archiveSwitch.isOn,
                    updatedAt: date,
                    pokemonName1: pokemonLabel1.text!,
                    pokemonName2: pokemonLabel2.text ?? "",
                    pokemonName3: pokemonLabel3.text ?? "",
                    pokemonName4: pokemonLabel4.text ?? "",
                    pokemonName5: pokemonLabel5.text ?? "",
                    pokemonName6: pokemonLabel6.text ?? ""
                )
            case Identifier.unwindCancel:
                break
            case Identifier.select:
//                let indexPath = tableView.indexPathForSelectedRow!
                let selectPokemonTVC = segue.destination as! SelectPokemonTableViewController
                selectPokemonTVC.delegate = self
//                selectPokemonTVC.selectedPokemon = tableView.cellForRow(at: indexPath)!.detailTextLabel?.text ?? ""
            default:
                break
            }
        }
    }
    
}

extension TeamDetailTableViewController: SelectPokemonTableViewControllerDelegate {
    
    func didSelect(selectedPokemon: String) {
        if let indexPath = tableView.indexPathForSelectedRow {
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.detailTextLabel?.text = selectedPokemon
            }
        }
    }
    
}

