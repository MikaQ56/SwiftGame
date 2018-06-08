//
//  Mage.swift
//  SwiftGame
//
//  Created by Mickael on 04/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Create character of type Mage
class Mage: Character {
    
    var care = 20
    
    override init(name: String){
        super.init(name: name)
        health = helmet["Wooden"]!
    }
    
    func care(target: Character){
        target.health += care
        Style.separatorForFlash()
        print("Le Mage a soigné \(target.name). Ce dernier a récupéré \(care) points de vie !")
        Style.separatorForFlash()
    }
}
