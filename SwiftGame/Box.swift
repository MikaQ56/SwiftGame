//
//  Box.swift
//  SwiftGame
//
//  Created by Mickael on 04/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Create Enumeration for Box & its content
enum Box {
    
    enum Weapon: Int {
        
        case sword, lance, dagger, bow, axe, gun
        
        func damage() -> Int{
            
            switch self {
                
            case .sword:
                return 40
            case .lance:
                return 10
            case .dagger:
                return 20
            case .bow:
                return 30
            case .axe:
                return 50
            case .gun:
                return 60
            }
        }
        
        static func random() -> Weapon {
            let random = Int.random(6)
            return Weapon(rawValue: random)!
        }
    }
    
    enum CarePower: Int {
        
        case strong, veryStrong, superStrong
        
        func care() -> Int{
            
            switch self {
                
            case .strong:
                return 40
            case .veryStrong:
                return 10
            case .superStrong:
                return 20
            }
        }
        
        static func random() -> CarePower {
            let random = Int.random(3)
            return CarePower(rawValue: random)!
        }
    }
}



