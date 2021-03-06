//
//  TeamListTableViewController.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-05.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit

class TeamListTableViewController: UITableViewController {
    
    // MARK: - TEST DATA
    var teamList: [Team] = [Team(name: "Yellow",
                                 createdAt: Date(),
                                 isArchive: false,
                                 updatedAt: Date(),
                                 pokemonName1: "Pikachu",
                                 pokemonName2: "Raichu",
                                 pokemonName3: "Sandshrew",
                                 pokemonName4: "Ponyta",
                                 pokemonName5: "Hypno",
                                 pokemonName6: "Drowzee"
        ),
    Team(name: "Red",
                             createdAt: Date(),
                             isArchive: false,
                             updatedAt: Date(),
                             pokemonName1: "Charizard",
                             pokemonName2: "Blastoise",
                             pokemonName3: "Venusaur",
                             pokemonName4: "Clefable",
                             pokemonName5: "Ninetales",
                             pokemonName6: "Vileplume"
    )]
    
    // MARK: - Dependency Injection
    var updatedTeam: Team?
    
    // MARK: - Identifier
    struct Identifier {
        static let editTeam = "EditTeamSegue"
        static let addTeam = "AddTeamSegue"
        static let cell = "TeamTableViewCell"
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.editTeam {
            let indexPath = tableView.indexPathForSelectedRow!
            let team = teamList[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let teamDetailTableVC = navController.topViewController as! TeamDetailTableViewController
            teamDetailTableVC.team = team
        }
    }
    
    @IBAction func unwindToTeamListTableView(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier, identifier == TeamDetailTableViewController.Identifier.unwindWithData {
            let sourceViewController = segue.source as! TeamDetailTableViewController
            if let team = sourceViewController.team {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    teamList[selectedIndexPath.row] = team
                    tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
                } else {
                    teamList.append(team)
                    tableView.insertRows(at: [IndexPath(row: teamList.count - 1, section: 0)], with: .automatic)
                }
            }
        }
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.cell, for: indexPath) as! TeamTableViewCell
        let team = teamList[indexPath.row]
        cell.updateUI(with: team)
        
        return cell
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            teamList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let teamToMove = teamList.remove(at: sourceIndexPath.row)
        teamList.insert(teamToMove, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Identifier.editTeam, sender: self)
    }
}
