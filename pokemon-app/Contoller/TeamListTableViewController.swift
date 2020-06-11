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
    var teamList: [Team] = [Team(
        name: "asdf",
        createdAt: Date(),
        isArchive: false,
        updatedAt: Date(),
        pokemonName1: "data1",
        pokemonName2: "data2",
        pokemonName3: "data3",
        pokemonName4: "data4",
        pokemonName5: "data5",
        pokemonName6: "data6"
        )]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamTableViewCell", for: indexPath) as! TeamTableViewCell
        let team = teamList[indexPath.row]
        
        cell.teamNameLabel.text = team.name
        cell.pokemon1Label.text = team.pokemonName1
        cell.pokemon2Label.text = team.pokemonName2
        cell.pokemon3Label.text = team.pokemonName3
        cell.pokemon4Label.text = team.pokemonName4
        cell.pokemon5Label.text = team.pokemonName5
        cell.pokemon6Label.text = team.pokemonName6

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TeamDetailSegue" {
            let teamDetailViewController = segue.destination as! TeamDetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            teamDetailViewController.team = teamList[index]
        }
    }
    
    @IBAction func unwindToTeamListTableView(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? TeamDetailViewController, sourceViewController.isEditted {
            let indexPath = tableView.indexPathForSelectedRow!
            teamList[indexPath.row] = sourceViewController.team
            DispatchQueue.main.async {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
    }
    

}
