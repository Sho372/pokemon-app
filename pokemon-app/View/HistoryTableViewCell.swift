//
//  HistoryTableViewCell.swift
//  pokemon-app
//
//  Created by 佐藤美佳 on 2020/06/08.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet var historyIdLabel: UILabel!
    @IBOutlet var resultImage: UIImageView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var teamNameLabel: UILabel!
    @IBOutlet var opponentLabel1: UILabel!
    @IBOutlet var opponentLabel2: UILabel!
    @IBOutlet var opponentLabel3: UILabel!
    @IBOutlet var opponentLabel4: UILabel!
    @IBOutlet var opponentLabel5: UILabel!
    @IBOutlet var opponentLabel6: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
