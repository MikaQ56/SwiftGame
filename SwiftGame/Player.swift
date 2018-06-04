//
//  Player.swift
//  SwiftGame
//
//  Created by Mickael on 04/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Create 'Player' class to manage game's players
class Player {
    
    // Player's name
    var name: String
    
    // Player's team. Array of 'Character' type
    var team = [Character]()
    
    // Initialize 'Player' class
    init(name: String){
        self.name = name
    }
    
}
