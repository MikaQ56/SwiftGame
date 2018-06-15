//
//  Colosse.swift
//  SwiftGame
//
//  Created by Mickael on 04/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Create character of type Colossus
class Colossus: Character {
    
    override init(name: String){
        super.init(name: name)
        strength = Box.Weapon.dagger.damage()
        health = helmet["Diamond"]!
        type = CharacterType.colossus.description()
    }
}
