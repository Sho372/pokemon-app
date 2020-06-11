//
//  HistoryDetailTableViewController.swift
//  pokemon-app
//
//  Created by 佐藤美佳 on 2020/06/10.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit
import CoreData

class HistoryDetailTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var history: ManagedHistory
    var screenMode: ScreenMode

    private var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var seasonPicker: UIPickerView!
    @IBOutlet var singleDoubleSegment: UISegmentedControl!
    @IBOutlet var teamPicker: UIPickerView!
    
    @IBOutlet var myPokemonLabel1: UILabel!
    @IBOutlet var myPokemonSwitch1: UISwitch!
    @IBOutlet var myPokemonLabel2: UILabel!
    @IBOutlet var myPokemonSwitch2: UISwitch!
    @IBOutlet var myPokemonLabel3: UILabel!
    @IBOutlet var myPokemonSwitch3: UISwitch!
    @IBOutlet var myPokemonLabel4: UILabel!
    @IBOutlet var myPokemonSwitch4: UISwitch!
    @IBOutlet var myPokemonLabel5: UILabel!
    @IBOutlet var myPokemonSwitch5: UISwitch!
    @IBOutlet var myPokemonLabel6: UILabel!
    @IBOutlet var myPokemonSwitch6: UISwitch!

    @IBOutlet var opponentTextField1: UITextField!
    @IBOutlet var opponentSwitch1: UISwitch!
    @IBOutlet var opponentTextField2: UITextField!
    @IBOutlet var opponentSwitch2: UISwitch!
    @IBOutlet var opponentTextField3: UITextField!
    @IBOutlet var opponentSwitch3: UISwitch!
    @IBOutlet var opponentTextField4: UITextField!
    @IBOutlet var opponentSwitch4: UISwitch!
    @IBOutlet var opponentTextField5: UITextField!
    @IBOutlet var opponentSwitch5: UISwitch!
    @IBOutlet var opponentTextField6: UITextField!
    @IBOutlet var opponentSwitch6: UISwitch!

    @IBOutlet var resultSegment: UISegmentedControl!
    @IBOutlet var rightBarButton: UIBarButtonItem!
    
    private var teams: [ManagedTeam]?
    private var seasons: [String] = ["March", "April", "June", "July"]
    private let seasonTag = 0
    private let teamTag = 1

    enum ScreenMode {
        case add, edit, refer
    }
    
    init(history: ManagedHistory, mode: ScreenMode) {
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
            
            myPokemonSwitch1.isEnabled = false
            myPokemonSwitch2.isEnabled = false
            myPokemonSwitch3.isEnabled = false
            myPokemonSwitch4.isEnabled = false
            myPokemonSwitch5.isEnabled = false
            myPokemonSwitch6.isEnabled = false
            
            opponentTextField1.isEnabled = false
            opponentTextField2.isEnabled = false
            opponentTextField3.isEnabled = false
            opponentTextField4.isEnabled = false
            opponentTextField5.isEnabled = false
            opponentTextField6.isEnabled = false
            opponentSwitch1.isEnabled = false
            opponentSwitch2.isEnabled = false
            opponentSwitch3.isEnabled = false
            opponentSwitch4.isEnabled = false
            opponentSwitch5.isEnabled = false
            opponentSwitch6.isEnabled = false

            resultSegment.isUserInteractionEnabled = false
            rightBarButton.title = "Edit"
            

        default:
            datePicker.isEnabled = true
            seasonPicker.isUserInteractionEnabled = true
            singleDoubleSegment.isEnabled = true
            teamPicker.isUserInteractionEnabled = true
            
            myPokemonSwitch1.isEnabled = true
            myPokemonSwitch2.isEnabled = true
            myPokemonSwitch3.isEnabled = true
            myPokemonSwitch4.isEnabled = true
            myPokemonSwitch5.isEnabled = true
            myPokemonSwitch6.isEnabled = true
            
            opponentTextField1.isEnabled = true
            opponentTextField2.isEnabled = true
            opponentTextField3.isEnabled = true
            opponentTextField4.isEnabled = true
            opponentTextField5.isEnabled = true
            opponentTextField6.isEnabled = true
            opponentSwitch1.isEnabled = true
            opponentSwitch2.isEnabled = true
            opponentSwitch3.isEnabled = true
            opponentSwitch4.isEnabled = true
            opponentSwitch5.isEnabled = true
            opponentSwitch6.isEnabled = true
            
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

    // Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == seasonTag {
            return seasons.count
        } else {
            if let count = teams?.count {
                return count
            }
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == seasonTag {
            return seasons[row]
        } else {
            if teams != nil && row < teams!.count {
                let team = teams![row]
                return team.name
            }
            return nil
        }
    }

    // Onchange event for team picker view
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == teamTag {
            let team = teams![row]
            myPokemonLabel1.text = team.pokemonName1 ?? ""
            myPokemonLabel2.text = team.pokemonName2 ?? ""
            myPokemonLabel3.text = team.pokemonName3 ?? ""
            myPokemonLabel4.text = team.pokemonName4 ?? ""
            myPokemonLabel5.text = team.pokemonName5 ?? ""
            myPokemonLabel6.text = team.pokemonName6 ?? ""
        }
    }
    
    // MARK: - Table view data source


    
    
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
