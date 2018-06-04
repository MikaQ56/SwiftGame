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
    
    // Enumeration for weapons available in the Box
    enum Weapons: Int {
        
        case Sword = 40
        case Lance = 30
        case Dagger = 10
        case Bow = 20
        case Axe = 50
        case Gun = 70
        case noWeapon = 5
    }
    
    // Enumeration for 'carePower' available in the Box
    enum CarePower: Int {
        
        case strong = 40
        case veryStrong = 60
        case superStrong = 80
    }
    
}
