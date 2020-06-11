//
//  TeamTableViewswift
//  pokemon-app
//
//  Created by 佐藤美佳 on 2020/06/02.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    @IBOutlet var teamNameLabel: UILabel!
    @IBOutlet var pokemon1Label: UILabel!
    @IBOutlet var pokemon2Label: UILabel!
    @IBOutlet var pokemon3Label: UILabel!
    @IBOutlet var pokemon4Label: UILabel!
    @IBOutlet var pokemon5Label: UILabel!
    @IBOutlet var pokemon6Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI(with team: Team) {
        teamNameLabel.text = team.name
        pokemon1Label.text = team.pokemonName1
        pokemon2Label.text = team.pokemonName2
        pokemon3Label.text = team.pokemonName3
        pokemon4Label.text = team.pokemonName4
        pokemon5Label.text = team.pokemonName5
        pokemon6Label.text = team.pokemonName6
    }
    
}
