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
    var type: CharacterType?
    
    // Character's Helmet
    let helmet = [
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
        let message = "\(name), \(type!.description()), a une force de \(strength) et \(health) points de vie\n"
        game.ui.introduceCharacter(message: message)
    }
    
    // Character's strike
    func strike(target: Character, player: Player){
        target.health -= strength
        let message = "\(name) a attaqué \(target.name). Ce dernier a perdu \(strength) points de vie !"
        game.ui.displayFightResult(message: message)
        if target.health <= 0 {
            player.delete(characterName: target.name)
            let message = "\(target.name) n'a pas résisté à l'attaque de \(name). Il est mort !"
            game.ui.characterIsDead(message: message)
        }
    }
    
    // Players select characters to create team
    static func edit(choice: Int, characterName: String) -> Character{
        if let choice = CharacterType(rawValue: choice){
            switch choice {
            case .fighter:
                return Fighter(name: characterName)
            case .magus:
                return Magus(name: characterName)
            case .colossus:
                return Colossus(name: characterName)
            case .dwarf:
                return Dwarf(name: characterName)
            }
        }
        return Fighter(name: characterName)
    }
    
    // Reset strength property if step 2 has runned...
    func resetStrength() {
        switch type! {
        case .colossus:
            strength = Box.Weapon.dagger.damage()
        case .dwarf:
            strength = Box.Weapon.axe.damage()
        case .fighter:
            strength = Box.Weapon.lance.damage()
        default:
            strength = Box.Weapon.lance.damage()
        }
    }
}
