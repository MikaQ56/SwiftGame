//
//  Mage.swift
//  SwiftGame
//
//  Created by Mickael on 04/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Create character of type Magus
class Magus: Character {
    
    var care = 20
    
    override init(name: String){
        super.init(name: name)
        health = helmet["Wooden"]!
        type = CharacterType.magus
    }
    
    func care(target: Character){
        target.health += care
        let message = "Le Mage a soigné \(target.name). Ce dernier a récupéré \(care) points de vie !"
        game.ui.displayCareResult(message: message)
    }
    
    override func introduction() {
        super.introduction()
        let message = "Mais il a un super pouvoir. Il peu soigné ses équipiers en leur redonnant \(self.care) points de vie\n"
        game.ui.displayCarePower(message: message)
    }
}
