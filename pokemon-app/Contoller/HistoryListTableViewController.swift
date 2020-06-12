//
//  HistoryListTableViewController.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-05.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit
import CoreData

class HistoryListTableViewController: UITableViewController {
    
    private let cellId = "HistoryCell"
    private let segueId = "toHistoryDetail"
    
    private var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    private var historyList: [ManagedHistory] = []
    
    private var selectedHistory: ManagedHistory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Bring team data from database
        
        //[Sampledata] START
        let firstHistory = History(teamName: "Yellow", seasonName: "March", isWin: true, isSingle: true, createdAt: Date(), updatedAt: Date())
        
        let secondHistory = History(teamName: "Red", seasonName: "March", isWin: false, isSingle: true, createdAt: Date(), updatedAt: Date())
        
        let selects = [
            SelectedPokemon(sequence: 1, selectedPokemonName: "Pikachu"),
            SelectedPokemon(sequence: 2, selectedPokemonName: "Raichu")
            ,SelectedPokemon(sequence: 3, selectedPokemonName: "Sandshrew")
        ]
        
        let opponets = [
            OpponentPokemon(sequence: 1, opponentPokemonName: "Charizard", isSelected: true),
            OpponentPokemon(sequence: 2, opponentPokemonName: "Blastoise", isSelected: false),
            OpponentPokemon(sequence: 3, opponentPokemonName: "Venusaur", isSelected: false),
            OpponentPokemon(sequence: 4, opponentPokemonName: "Clefable", isSelected: true),
            OpponentPokemon(sequence: 5, opponentPokemonName: "Ninetales", isSelected: false),
            OpponentPokemon(sequence: 6, opponentPokemonName: "Vileplume", isSelected: true),
        ]
        //[Sample data] END
        
        //insert sample history data
        self.createHistory(history: firstHistory, selectPokemons: selects, opponentPokemons: opponets)
        self.createHistory(history: secondHistory, selectPokemons: selects, opponentPokemons: opponets)

        // Bring team data from database
        loadHistoryData()

        // Filter histories only matchs with selected team
    }
    
    private func loadHistoryData(){
        let context = container?.viewContext
        self.historyList = ManagedHistory.fetchAll(in: context!)
    }

    //MARK: move this function to appropriate place.
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.historyList.count
    }

    // MARK: Fix this after implementing CoreData part
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HistoryTableViewCell
        let history = historyList[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        cell.dateLabel.text = formatter.string(from: history.createdAt!)
        cell.teamNameLabel.text = history.teamName
//        print((history.opponentPokemons!.allObjects[0] as! ManagedOpponentPokemons).opponentPokemonName!)
        cell.opponentLabel1.text = (history.opponentPokemons!.allObjects[0] as! ManagedOpponentPokemons).opponentPokemonName!
        cell.opponentLabel2.text = (history.opponentPokemons!.allObjects[1] as! ManagedOpponentPokemons).opponentPokemonName!
        cell.opponentLabel3.text = (history.opponentPokemons!.allObjects[2] as! ManagedOpponentPokemons).opponentPokemonName!
        cell.opponentLabel4.text = (history.opponentPokemons!.allObjects[3] as! ManagedOpponentPokemons).opponentPokemonName!
        cell.opponentLabel5.text = (history.opponentPokemons!.allObjects[4] as! ManagedOpponentPokemons).opponentPokemonName!
        cell.opponentLabel6.text = (history.opponentPokemons!.allObjects[5] as! ManagedOpponentPokemons).opponentPokemonName!

        if history.isWin {
            cell.resultImage.image = UIImage(systemName: "circle")
        } else {
            cell.resultImage.image = UIImage(systemName: "multiply")
        }

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedHistory = historyList[indexPath.row]
        
        performSegue(withIdentifier: segueId, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueId {
            let detailView = segue.destination as! HistoryDetailTableViewController
            detailView.screenMode = HistoryDetailTableViewController.ScreenMode.refer
            detailView.historyId = selectedHistory?.objectID
        }
    }
}
