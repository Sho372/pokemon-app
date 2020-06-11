//
//  HistoryDetailTableViewController.swift
//  pokemon-app
//
//  Created by 佐藤美佳 on 2020/06/10.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit
import CoreData

class HistoryDetailTableViewController: UITableViewController {

    var history: History
    var screenMode: ScreenMode

    private var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var seasonPicker: UIPickerView!
    @IBOutlet var singleDoubleSegment: UISegmentedControl!
    @IBOutlet var teamPicker: UIPickerView!
    @IBOutlet var myPokemonLabel: UILabel!
    @IBOutlet var myPokemonSwitch: UISwitch!
    @IBOutlet var opponentPokemonLabel: UILabel!
    @IBOutlet var opponentPokemonSwitch: UISwitch!
    @IBOutlet var resultSegment: UISegmentedControl!
    @IBOutlet var rightBarButton: UIBarButtonItem!
    
    private var teams: [ManagedTeam]?
    
    enum ScreenMode {
        case add, edit, refer
    }
    
    init(history: History, mode: ScreenMode) {
        self.history = history
        self.screenMode = mode
        super.init(nibName: nil, bundle: nil)
        container?.performBackgroundTask{ context in
            self.teams = ManagedTeam.fetchAll(in: context)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setScreen() {
        switch screenMode {
        case .refer:
            datePicker.isEnabled = false
            seasonPicker.isUserInteractionEnabled = false
            singleDoubleSegment.isEnabled = false
            teamPicker.isUserInteractionEnabled = false
            myPokemonLabel.isEnabled = false
            myPokemonSwitch.isEnabled = false
            opponentPokemonLabel.isEnabled = false
            opponentPokemonSwitch.isEnabled = false
            resultSegment.isUserInteractionEnabled = false
            rightBarButton.title = "Edit"
        default:
            datePicker.isEnabled = true
            seasonPicker.isUserInteractionEnabled = true
            singleDoubleSegment.isEnabled = true
            teamPicker.isUserInteractionEnabled = true
            myPokemonLabel.isEnabled = true
            myPokemonSwitch.isEnabled = true
            opponentPokemonLabel.isEnabled = true
            opponentPokemonSwitch.isEnabled = true
            resultSegment.isUserInteractionEnabled = true
            rightBarButton.title = "Done"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 7
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
