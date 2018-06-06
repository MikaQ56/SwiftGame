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
    enum Weapon: Int {
        
        case sword = 40
        case lance = 30
        case dagger = 10
        case bow = 20
        case axe = 50
        case gun = 70
        case noWeapon = 5
    }
    
    // Enumeration for 'carePower' available in the Box
    enum CarePower: Int {
        
        case strong = 40
        case veryStrong = 60
        case superStrong = 80
    }
    
}
