//
//  TeamDetailViewController.swift
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
    @IBOutlet var pokemon1TextField: UITextField!
    @IBOutlet var pokemon2TextField: UITextField!
    @IBOutlet var pokemon3TextField: UITextField!
    @IBOutlet var pokemon4TextField: UITextField!
    @IBOutlet var pokemon5TextField: UITextField!
    @IBOutlet var pokemon6TextField: UITextField!
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
            pokemon1TextField.text = team.pokemonName1
            pokemon2TextField.text = team.pokemonName2
            pokemon3TextField.text = team.pokemonName3
            pokemon4TextField.text = team.pokemonName4
            pokemon5TextField.text = team.pokemonName5
            pokemon6TextField.text = team.pokemonName6
        }
    }
    
    private func validateTextFields() {
        let n = teamNameTextField.text ?? ""
        let p1 = pokemon1TextField.text ?? ""
        
        saveButton.isEnabled = !n.isEmpty && !p1.isEmpty
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.unwind {
            team = Team(
                name: teamNameTextField.text ?? "",
                createdAt: isEditingTeam ? team!.createdAt : Date(),
                isArchive: archiveSwitch.isOn,
                updatedAt: Date(),
                pokemonName1: pokemon1TextField.text!,
                pokemonName2: pokemon2TextField.text ?? "",
                pokemonName3: pokemon3TextField.text ?? "",
                pokemonName4: pokemon4TextField.text ?? "",
                pokemonName5: pokemon5TextField.text ?? "",
                pokemonName6: pokemon6TextField.text ?? ""
            )
        }
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        validateTextFields()
    }
    
    @IBAction func returnKeyPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
