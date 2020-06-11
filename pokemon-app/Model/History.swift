//
//  History.swift
//  pokemon-app
//
//  Created by Richard Cho on 2020-06-05.
//  Copyright © 2020 user169300. All rights reserved.
//

import Foundation

struct History {
    var id: Int
    var date: Date
    var season: String
    var party: [Pokemon]
    var isChosen: [Bool]
    var battleResult: Bool
}
