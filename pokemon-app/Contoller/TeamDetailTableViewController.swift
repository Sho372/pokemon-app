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
        static let unwind = "UnwindToTeamListTableView"
    }
    
    // MARK: - FLAG
    private var isEditingTeam = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let team = team {
            isEditingTeam = true
            teamNameTextField.text = team.name
            archiveSwitch.isOn = team.isArchive
            pokemonLabel1.text = team.pokemonName1
            pokemonLabel2.text = team.pokemonName2
            pokemonLabel3.text = team.pokemonName3
            pokemonLabel4.text = team.pokemonName4
            pokemonLabel5.text = team.pokemonName5
            pokemonLabel6.text = team.pokemonName6
        }
        validateTexts()
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        validateTexts()
    }
    
    @IBAction func returnKeyPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    private func validateTexts() {
        let n = teamNameTextField.text ?? ""
        let p1 = pokemonLabel1.text ?? ""
        
        saveButton.isEnabled = !n.isEmpty && !p1.isEmpty
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section) {
        case (2):
            let selectPokemonTVC = SelectPokemonTableViewController()
            selectPokemonTVC.delegate = self
            navigationController?.pushViewController(selectPokemonTVC, animated: true)
        default:
            break;
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.unwind {
            team = Team(
                name: teamNameTextField.text ?? "",
                createdAt: isEditingTeam ? team!.createdAt : Date(),
                isArchive: archiveSwitch.isOn,
                updatedAt: Date(),
                pokemonName1: pokemonLabel1.text!,
                pokemonName2: pokemonLabel2.text ?? "",
                pokemonName3: pokemonLabel3.text ?? "",
                pokemonName4: pokemonLabel4.text ?? "",
                pokemonName5: pokemonLabel5.text ?? "",
                pokemonName6: pokemonLabel6.text ?? ""
            )
        }
    }
    
    
    
}

extension TeamDetailTableViewController: SelectPokemonTableViewControllerDelegate {
    
    func didSelect(name: String) {
        
    }
    
}
