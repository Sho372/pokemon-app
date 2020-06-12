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

    var historyId: NSManagedObjectID?
    var team: Team?
    var screenMode: ScreenMode?

    private var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var seasonPicker: UIPickerView!
    @IBOutlet var singleDoubleSegment: UISegmentedControl!
    @IBOutlet var teamLabel: UILabel!
    
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
    
    private let segueId = "toSelf"
    
    private var seasons: [String] = [String]()
    private var selectedSeason: String?
    
    private var selectedPokemon: [Int: String] = [:]
    private var selectedOpponent: [Int: String] = [:]

    enum ScreenMode {
        case add, edit, refer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.seasonPicker.delegate = self
        self.seasonPicker.dataSource = self
        self.seasons = ["March", "April", "June", "July"]
        
        switch screenMode {
        case .add:
            self.teamLabel.text = team?.name
            self.myPokemonLabel1.text = team?.pokemonName1 ?? ""
            self.myPokemonLabel2.text = team?.pokemonName2 ?? ""
            self.myPokemonLabel3.text = team?.pokemonName3 ?? ""
            self.myPokemonLabel4.text = team?.pokemonName4 ?? ""
            self.myPokemonLabel5.text = team?.pokemonName5 ?? ""
            self.myPokemonLabel6.text = team?.pokemonName6 ?? ""
            self.selectedSeason = seasons.first
        default:
            getData()
        }
        
        setScreen()
    }

    private func getData() {
        let history = try? ManagedHistory.fetchWithObjectId(objectId: historyId!, in: container!.viewContext)
        if history != nil {
            let tmpTeam = try? ManagedTeam.findTeam(matching: history!.teamName!, in: container!.viewContext)
            
            self.datePicker.date = history!.createdAt!
            for i in 0..<seasons.count {
                if seasons[i] == history?.seasonName {
                    seasonPicker.selectedRow(inComponent: i)
                    break
                }
            }
            self.singleDoubleSegment.selectedSegmentIndex = history!.isSingle ? 0 : 1
            self.teamLabel.text = history!.teamName
            
            self.myPokemonLabel1.text = tmpTeam?.pokemonName1
            self.myPokemonLabel2.text = tmpTeam?.pokemonName2
            self.myPokemonLabel3.text = tmpTeam?.pokemonName3
            self.myPokemonLabel4.text = tmpTeam?.pokemonName4
            self.myPokemonLabel5.text = tmpTeam?.pokemonName5
            self.myPokemonLabel6.text = tmpTeam?.pokemonName6

            let tmpSelected = (history!.selectedPokemons?.allObjects as! [ManagedSelectedPokemons])
            for p in tmpSelected {
                if p.selectedPokemonName == tmpTeam?.pokemonName1 {
                    self.myPokemonSwitch1.isOn = true
                    selectedPokemon[1] = tmpTeam?.pokemonName1
                }
                if p.selectedPokemonName == tmpTeam?.pokemonName2 {
                    self.myPokemonSwitch2.isOn = true
                    selectedPokemon[2] = tmpTeam?.pokemonName2
                }
                if p.selectedPokemonName == tmpTeam?.pokemonName3 {
                    self.myPokemonSwitch3.isOn = true
                    selectedPokemon[3] = tmpTeam?.pokemonName3
                }
                if p.selectedPokemonName == tmpTeam?.pokemonName4 {
                    self.myPokemonSwitch4.isOn = true
                    selectedPokemon[4] = tmpTeam?.pokemonName4
                }
                if p.selectedPokemonName == tmpTeam?.pokemonName5 {
                    self.myPokemonSwitch5.isOn = true
                    selectedPokemon[5] = tmpTeam?.pokemonName5
                }
                if p.selectedPokemonName == tmpTeam?.pokemonName6 {
                    self.myPokemonSwitch6.isOn = true
                    selectedPokemon[6] = tmpTeam?.pokemonName6
                }
            }
            
            self.opponentTextField1.text = (history!.opponentPokemons?.allObjects[0] as! ManagedOpponentPokemons).opponentPokemonName
            self.opponentTextField2.text = (history!.opponentPokemons?.allObjects[1] as! ManagedOpponentPokemons).opponentPokemonName
            self.opponentTextField3.text = (history!.opponentPokemons?.allObjects[2] as! ManagedOpponentPokemons).opponentPokemonName
            self.opponentTextField4.text = (history!.opponentPokemons?.allObjects[3] as! ManagedOpponentPokemons).opponentPokemonName
            self.opponentTextField5.text = (history!.opponentPokemons?.allObjects[4] as! ManagedOpponentPokemons).opponentPokemonName
            self.opponentTextField6.text = (history!.opponentPokemons?.allObjects[5] as! ManagedOpponentPokemons).opponentPokemonName
            
            self.opponentSwitch1.isOn = (history!.opponentPokemons?.allObjects[0] as! ManagedOpponentPokemons).isSelected
            if self.opponentSwitch1.isOn { selectedOpponent[1] = self.opponentTextField1.text }
            self.opponentSwitch2.isOn = (history!.opponentPokemons?.allObjects[1] as! ManagedOpponentPokemons).isSelected
            if self.opponentSwitch2.isOn { selectedOpponent[2] = self.opponentTextField2.text }
            self.opponentSwitch3.isOn = (history!.opponentPokemons?.allObjects[2] as! ManagedOpponentPokemons).isSelected
            if self.opponentSwitch3.isOn { selectedOpponent[3] = self.opponentTextField3.text }
            self.opponentSwitch4.isOn = (history!.opponentPokemons?.allObjects[3] as! ManagedOpponentPokemons).isSelected
            if self.opponentSwitch4.isOn { selectedOpponent[4] = self.opponentTextField4.text }
            self.opponentSwitch5.isOn = (history!.opponentPokemons?.allObjects[4] as! ManagedOpponentPokemons).isSelected
            if self.opponentSwitch5.isOn { selectedOpponent[5] = self.opponentTextField5.text }
            self.opponentSwitch6.isOn = (history!.opponentPokemons?.allObjects[5] as! ManagedOpponentPokemons).isSelected
            if self.opponentSwitch6.isOn { selectedOpponent[6] = self.opponentTextField6.text }

            self.resultSegment.selectedSegmentIndex = history!.isWin ? 0 : 1
        }
        
    }
    
    private func setScreen() {
        switch screenMode {
        case .refer:
            datePicker.isEnabled = false
            seasonPicker.isUserInteractionEnabled = false
            singleDoubleSegment.isEnabled = false
            
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
            self.navigationItem.rightBarButtonItems?.remove(at: 1)

        default:
            datePicker.isEnabled = true
            seasonPicker.isUserInteractionEnabled = true
            singleDoubleSegment.isEnabled = true
            
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
            self.navigationItem.rightBarButtonItems?.remove(at: 0)

        }
    }
    
    // Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return seasons.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return seasons[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSeason = seasons[row]
    }
    
    @IBAction func tapMyPokemonSwitch(_ sender: UISwitch) {
        if sender.isOn {
            if sender == myPokemonSwitch1 {
                selectedPokemon[1] = myPokemonLabel1.text
            }
            if sender == myPokemonSwitch2 {
                selectedPokemon[2] = myPokemonLabel1.text
            }
            if sender == myPokemonSwitch3 {
                selectedPokemon[3] = myPokemonLabel1.text
            }
            if sender == myPokemonSwitch4 {
                selectedPokemon[4] = myPokemonLabel1.text
            }
            if sender == myPokemonSwitch5 {
                selectedPokemon[5] = myPokemonLabel1.text
            }
            if sender == myPokemonSwitch6 {
                selectedPokemon[6] = myPokemonLabel1.text
            }
        } else {
            if sender == myPokemonSwitch1 {
                selectedPokemon.removeValue(forKey: 1)
            }
            if sender == myPokemonSwitch2 {
                selectedPokemon.removeValue(forKey: 2)
            }
            if sender == myPokemonSwitch3 {
                selectedPokemon.removeValue(forKey: 3)
            }
            if sender == myPokemonSwitch4 {
                selectedPokemon.removeValue(forKey: 4)
            }
            if sender == myPokemonSwitch5 {
                selectedPokemon.removeValue(forKey: 5)
            }
            if sender == myPokemonSwitch6 {
                selectedPokemon.removeValue(forKey: 6)
            }
        }
    }
    
    @IBAction func tapOpponentSwitch(_ sender: UISwitch) {
        if sender.isOn {
            if sender == opponentSwitch1 {
                selectedOpponent[1] = opponentTextField1.text
            }
            if sender == opponentSwitch2 {
                selectedOpponent[2] = opponentTextField2.text
            }
            if sender == opponentSwitch3 {
                selectedOpponent[3] = opponentTextField3.text
            }
            if sender == opponentSwitch4 {
                selectedOpponent[4] = opponentTextField4.text
            }
            if sender == opponentSwitch5 {
                selectedOpponent[5] = opponentTextField5.text
            }
            if sender == opponentSwitch6 {
                selectedOpponent[6] = opponentTextField6.text
            }
        } else {
            if sender == opponentSwitch1 {
                selectedOpponent.removeValue(forKey: 1)
            }
            if sender == opponentSwitch2 {
                selectedOpponent.removeValue(forKey: 2)
            }
            if sender == opponentSwitch3 {
                selectedOpponent.removeValue(forKey: 3)
            }
            if sender == opponentSwitch4 {
                selectedOpponent.removeValue(forKey: 4)
            }
            if sender == opponentSwitch5 {
                selectedOpponent.removeValue(forKey: 5)
            }
            if sender == opponentSwitch6 {
                selectedOpponent.removeValue(forKey: 6)
            }
        }
    }
    
    
    @IBAction func tapDoneButton(_ sender: UIBarButtonItem) {
        updateData()
        self.navigationController?.popViewController(animated: true)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueId {
            let destinationVC = segue.destination as! HistoryDetailTableViewController
            destinationVC.screenMode = ScreenMode.edit
            destinationVC.historyId = historyId
        }
    }
    
    private func updateData() {
        let isWin = resultSegment.selectedSegmentIndex == 0
        let isSingle = singleDoubleSegment.selectedSegmentIndex == 0
        let history = History(teamName: teamLabel.text!, seasonName: selectedSeason!, isWin: isWin, isSingle: isSingle, createdAt: Date(), updatedAt: Date())
        var selectedPokemonList = [SelectedPokemon]()
        for sp in selectedPokemon {
            selectedPokemonList.append(SelectedPokemon(sequence: Int16(sp.key), selectedPokemonName: sp.value))
        }
        var opponentList = [OpponentPokemon]()
        opponentList.append(OpponentPokemon(sequence: 1, opponentPokemonName: opponentTextField1.text!, isSelected: opponentSwitch1.isOn))
        opponentList.append(OpponentPokemon(sequence: 2, opponentPokemonName: opponentTextField2.text!, isSelected: opponentSwitch2.isOn))
        opponentList.append(OpponentPokemon(sequence: 3, opponentPokemonName: opponentTextField3.text!, isSelected: opponentSwitch3.isOn))
        opponentList.append(OpponentPokemon(sequence: 4, opponentPokemonName: opponentTextField4.text!, isSelected: opponentSwitch4.isOn))
        opponentList.append(OpponentPokemon(sequence: 5, opponentPokemonName: opponentTextField5.text!, isSelected: opponentSwitch5.isOn))
        opponentList.append(OpponentPokemon(sequence: 6, opponentPokemonName: opponentTextField6.text!, isSelected: opponentSwitch6.isOn))
        
        createHistory(history: history, selectPokemons: selectedPokemonList, opponentPokemons: opponentList)
    }
    
    private func createHistory(history historyInfo: History, selectPokemons selects: [SelectedPokemon], opponentPokemons opponets: [OpponentPokemon]) {
        
        //get context
        let context = container?.viewContext
        //insert selected pokmon data
        let managedSelects = selects.map{
            try? ManagedSelectedPokemons.createSelectedPokemon(sequence: 1, selectedPokemonName: $0.selectedPokemonName, in: context!)
        }
        //insert opponent pokemon data
        let managedOpponents = opponets.map{
            try? ManagedOpponentPokemons.createOpponentPokemon(sequence: 1, opponetPokemonName: $0.opponentPokemonName, isSelected: $0.isSelected, in: context!)
        }
        //insert history data
        _ = try? ManagedHistory.createHistory(history: historyInfo, selectedPokemons: managedSelects, opponentPokemons: managedOpponents, in: context!)
        //commit
        _ = try? context!.save()
    }

}
