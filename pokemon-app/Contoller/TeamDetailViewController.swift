//
//  TeamDetailViewController.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-05.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit

class TeamDetailViewController: UIViewController {

    // MARK: - Dependency Injection
    var team: Team!
    
    @IBOutlet var teamNameTextField: UITextField!
    @IBOutlet var archiveSwitch: UISwitch!
    @IBOutlet var pokemon1TextField: UITextField!
    @IBOutlet var pokemon2TextField: UITextField!
    @IBOutlet var pokemon3TextField: UITextField!
    @IBOutlet var pokemon4TextField: UITextField!
    @IBOutlet var pokemon5TextField: UITextField!
    @IBOutlet var pokemon6TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
