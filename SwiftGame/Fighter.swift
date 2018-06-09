//
//  Combattant.swift
//  SwiftGame
//
//  Created by Mickael on 04/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Create character of type Fighter
class Fighter: Character {
    
    override init(name: String){
        super.init(name: name)
        strength = Box.Weapon.dagger.damage()
        health = helmet["Iron"]!
        type = CharacterType.fighter.description()
        
    }
}
