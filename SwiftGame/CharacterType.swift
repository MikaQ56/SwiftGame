//
//  CharacterType.swift
//  SwiftGame
//
//  Created by Mickael on 08/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

enum CharacterType: Int{
    
    case fighter = 1, magus, colossus, dwarf
    
    func description() -> String{
        
        switch self {
            
        case .fighter:
            
            return "Le Combattant"
        case .magus:
            
            return "Le Mage"
        case .colossus:
            
            return "Le Colosse"
        case .dwarf:
            
            return "Le Nain"
        }
    }
    
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
    
    static func allCases() -> [CharacterType]{
        
        var allCases = [CharacterType]()
        
        for i in 1...10{
            
            if let type = CharacterType(rawValue: i){
                allCases.append(type)
            }
            else{
                return allCases
            }
        }
        
        return allCases
    }
}
