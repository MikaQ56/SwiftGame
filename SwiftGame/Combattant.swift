//
//  Combattant.swift
//  SwiftGame
//
//  Created by Mickael on 04/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Create character of type Combattant
class Combattant: Character {
    
    override init(name: String){
        super.init(name: name)
        strength = Box.Weapon.dagger.rawValue
        health = helmet["Iron"]!
    }
}
