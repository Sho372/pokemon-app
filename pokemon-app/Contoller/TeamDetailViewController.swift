//
//  TeamDetailViewController.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-05.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit

class TeamDetailViewController: UIViewController {
    
    struct Identifier {
        static let unwind = "UnwindToTeamListTableView"
    }
    
    // MARK: - Dependency Injection
    var team: Team!
    
    var isEditted = false
    
    var isAnythingEmpty: Bool {
        get {
            if teamNameTextField.text?.isEmpty ?? true
                || pokemon1TextField.text?.isEmpty ?? true
                || pokemon2TextField.text?.isEmpty ?? true
                || pokemon3TextField.text?.isEmpty ?? true
                || pokemon4TextField.text?.isEmpty ?? true
                || pokemon5TextField.text?.isEmpty ?? true
                || pokemon6TextField.text?.isEmpty ?? true {
                return true
            } else {
                return false
            }
        }
    }
    
    @IBOutlet var teamNameTextField: UITextField!
    @IBOutlet var archiveSwitch: UISwitch!
    @IBOutlet var pokemon1TextField: UITextField!
    @IBOutlet var pokemon2TextField: UITextField!
    @IBOutlet var pokemon3TextField: UITextField!
    @IBOutlet var pokemon4TextField: UITextField!
    @IBOutlet var pokemon5TextField: UITextField!
    @IBOutlet var pokemon6TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamNameTextField.text = team.name
        pokemon1TextField.text = team.pokemonName1
        pokemon2TextField.text = team.pokemonName2
        pokemon3TextField.text = team.pokemonName3
        pokemon4TextField.text = team.pokemonName4
        pokemon5TextField.text = team.pokemonName5
        pokemon6TextField.text = team.pokemonName6
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        isEditted = true
        teamNameTextField.isUserInteractionEnabled.toggle()
        pokemon1TextField.isUserInteractionEnabled.toggle()
        pokemon2TextField.isUserInteractionEnabled.toggle()
        pokemon3TextField.isUserInteractionEnabled.toggle()
        pokemon4TextField.isUserInteractionEnabled.toggle()
        pokemon5TextField.isUserInteractionEnabled.toggle()
        pokemon6TextField.isUserInteractionEnabled.toggle()
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
//        if isEditted {
            team.name = teamNameTextField.text!
            team.pokemonName1 = pokemon1TextField.text!
            team.pokemonName2 = pokemon2TextField.text!
            team.pokemonName3 = pokemon3TextField.text!
            team.pokemonName4 = pokemon4TextField.text!
            team.pokemonName5 = pokemon5TextField.text!
            team.pokemonName6 = pokemon6TextField.text!
//        }
        performSegue(withIdentifier: Identifier.unwind, sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == Identifier.unwind { }
    }
    
}
