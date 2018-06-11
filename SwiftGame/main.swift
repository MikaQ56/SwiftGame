//
//  main.swift
//  SwiftGame
//
//  Created by Mickael on 04/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

let allCases = CharacterType.allCases()

// Initialize game
let game = Game(characterTypes: allCases, ui: ConsoleUI())


// Run the game
game.run()
