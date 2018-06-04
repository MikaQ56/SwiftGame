//
//  Game.swift
//  SwiftGame
//
//  Created by Mickael on 04/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Create a 'Game' class to manage the game (parameters, rules, running...)
class Game {
    
    // Players in the game...
    var players = [Player]()
    
    // Players' max number in the game
    var playersMax = 2
    
    // Characters created by players to set up their teams
    var characters = [Character]()
    
    // List of character types
    var characterTypes = ["Le Combattant", "Le Mage", "Le Colosse", "Le Nain"]
}
