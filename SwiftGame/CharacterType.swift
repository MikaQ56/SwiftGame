//
//  CharacterType.swift
//  SwiftGame
//
//  Created by Mickael on 08/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

enum CharacterType: Int{
    
    case fighter, magus, colossus, dwarf
    
    func description(){
        
        switch self {
            
        case .fighter:
            
            print("Le Combattant")
        case .magus:
            
            print("Le Mage")
        case .colossus:
            
            print("Le Colosse")
        case .dwarf:
            
            print("Le Nain")
        }
    }
    
    static func allCases() -> [CharacterType]{
        
        var allCases = [CharacterType]()
        
        for i in 0...10{
            
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
