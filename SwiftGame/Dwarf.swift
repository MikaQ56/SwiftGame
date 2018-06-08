//
//  Nain.swift
//  SwiftGame
//
//  Created by Mickael on 04/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Create character of type Dwarf
class Dwarf: Character {
    
    override init(name: String){
        super.init(name: name)
        strength = Box.Weapon.axe.rawValue
        health = helmet["Wooden"]!
    }
}
