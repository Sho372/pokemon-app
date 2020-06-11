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
    
    private var container: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    private var historyList: [ManagedHistory] = []

    // MARK: Fix this after implementing CoreData part
//    var historyList: [History] = [
//        History(date: Date(), season: "June", party: [Pokemon(name: "Pikachu")], isChosen: [true], battleResult: true),
//        History(date: Date(), season: "May", party: [Pokemon(name: "Ditto")], isChosen: [true], battleResult: false)
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Bring team data from database
        let firstHistory = History(teamName: "team1", seasonName: "season1", isWin: true, isSingle: true, createdAt: Date(), updatedAt: Date())
        
        let secondHistory = History(teamName: "team2", seasonName: "season3", isWin: true, isSingle: true, createdAt: Date(), updatedAt: Date())
        let context = container?.viewContext
        try? ManagedHistory.createHistory(history: firstHistory, selectedPokemons: [], opponentPokemons: [], in: context!)
        try? ManagedHistory.createHistory(history: secondHistory, selectedPokemons: [], opponentPokemons: [], in: context!)
        try? context!.save()
        // Bring team data from database
        loadHistoryData()
        print(self.historyList)
        // Filter histories only matchs with selected team
    }
    
    private func loadHistoryData(){
        let context = container?.viewContext
        self.historyList = ManagedHistory.fetchAll(in: context!)
    }

    // MARK: - Table view data source

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
//        cell.opponentLabel1.text = history.opponentPokemons?.allObjects[0] as? String
        
        if history.isWin {
            cell.resultImage.image = UIImage(systemName: "circle")
        } else {
            cell.resultImage.image = UIImage(systemName: "multiply")
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHistoryDetail" {
            let detailView = segue.destination as! HistoryDetailViewController
        }
    }
}
