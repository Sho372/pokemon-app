//
//  HistoryListTableViewController.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-05.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit

class HistoryListTableViewController: UITableViewController {
    
    private let cellId = "HistoryCell"
    private let segueId = "toHistoryDetail"
    
    // MARK: Fix this after implementing CoreData part
    private var historyList: [History] = []
    
    private var selectedHistory: History?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bring team data from database
        // Filter histories only matchs with selected team
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return historyList.count
    }

    // MARK: Fix this after implementing CoreData part
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HistoryTableViewCell
        let history = historyList[indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        cell.dateLabel.text = formatter.string(from: history.date)
        cell.opponentLabel1.text = history.party[0].name
        
        if history.battleResult {
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
            detailView.history = selectedHistory!
        }
    }
}
