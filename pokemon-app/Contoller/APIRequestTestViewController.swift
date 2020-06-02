//
//  APIRequestTestViewController.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-01.
//  Copyright © 2020 user169300. All rights reserved.
//

import UIKit

class APIRequestTestViewController: UIViewController {

//    private var networkAPI: PokeAPIRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        networkAPI = PokeAPIRequest.shared
    }
    
    @IBAction func pokeAPIRequestTest(_ sender: UIButton) {
        PokeAPIRequest.shared.getPokemonNames { (pokemons) in
            if let pokemons = pokemons?.results {
                print(pokemons.map { $0.name })
            }
        }
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
