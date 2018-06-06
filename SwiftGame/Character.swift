//
//  Character.swift
//  SwiftGame
//
//  Created by Mickael on 04/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Create 'Character' class to manage characters in the game
class Character {
    
    // Character's name
    var name: String
    
    // Character's health points
    var health = 0
    
    // Character's strength points
    var strength = 0
    
    // Character's type
    var type = String()
    
    // Character's Helmet
    var helmet = [
        "Wooden": 50,
        "Iron": 100,
        "Diamond": 150
    ]
    
    // Initialize Character
    init(name: String){
        
        self.name = name
    }
    
    // Character's greeting
    func introduction(){
        
        print("\(name), est un \(type), il a une force de \(strength) et \(health) points de vie\n")
    }
    
    // Character's strike
    func strike(target: Character, player: Player){
        
        target.health -= strength
        Style.separatorForFlash()
        print("\(name) a attaqué \(target.name). Ce dernier a perdu \(strength) points de vie !")
        Style.separatorForFlash()
        
        if target.health <= 0 {
            player.delete(characterName: target.name)
            Style.separatorForFlash()
            print("\(target.name) n'a pas résisté à l'attaque de \(name). Il est mort !")
            Style.separatorForFlash()
        }
    }
}
