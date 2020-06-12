//
//  TeamSelectViewController.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-05.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit
import CoreData

class TeamSelectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var teamPicker: UIPickerView!
    
    private var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    private let segueId = "toHistoryDetail"
    private var teams: [Team] = [Team]()
    private var teamNames: [String] = [String]()
    private var selectedTeam: Team?

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateDatabase()
//        container?.performBackgroundTask{ context in
//            self.teams = ManagedTeam.fetchAll(in: context)
//
//            if self.teams != nil {
//                for team in self.teams! {
//                    self.teamNames?.append(team.name!)
//                }
//            }
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamPicker.delegate = self
        teamPicker.dataSource = self
    }

    // Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return teamNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return teamNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTeam = teams[row]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueId {
            let destinationVC = segue.destination as! HistoryDetailTableViewController
            destinationVC.screenMode = HistoryDetailTableViewController.ScreenMode.add
            destinationVC.team = selectedTeam
        }
    }

    private func updateDatabase(){
        container?.performBackgroundTask{ context in
            let firstTeam = Team(name: "Yellow",
                                     createdAt: Date(),
                                     isArchive: false,
                                     updatedAt: Date(),
                                     pokemonName1: "Pikachu",
                                     pokemonName2: "Raichu",
                                     pokemonName3: "Sandshrew",
                                     pokemonName4: "Ponyta",
                                     pokemonName5: "Hypno",
                                     pokemonName6: "Drowzee"
            )
            let secondTeam = Team(name: "Red",
                                     createdAt: Date(),
                                     isArchive: false,
                                     updatedAt: Date(),
                                     pokemonName1: "Charizard",
                                     pokemonName2: "Blastoise",
                                     pokemonName3: "Venusaur",
                                     pokemonName4: "Clefable",
                                     pokemonName5: "Ninetales",
                                     pokemonName6: "Vileplume"
            )
            _ = try? ManagedTeam.findOrCreateTeam(matching: firstTeam, in: context)
            _ = try? ManagedTeam.findOrCreateTeam(matching: secondTeam, in: context)
            _ = try? context.save()
            
            let managedTeams = ManagedTeam.fetchAll(in: context)
            for team in managedTeams {
                self.teams.append(Team(
                    name: team.name!,
                    createdAt: team.createdAt!,
                    isArchive: team.isArchive,
                    updatedAt: team.updatedAt!,
                    pokemonName1: team.pokemonName1!,
                    pokemonName2: team.pokemonName2,
                    pokemonName3: team.pokemonName3,
                    pokemonName4: team.pokemonName4,
                    pokemonName5: team.pokemonName5,
                    pokemonName6: team.pokemonName6))

                self.teamNames.append(team.name!)
            }
            
            self.selectedTeam = self.teams.first

        }
    }
}
