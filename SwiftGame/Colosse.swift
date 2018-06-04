//
//  Colosse.swift
//  SwiftGame
//
//  Created by Mickael on 04/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Create character of type Colosse
class Colosse: Character {
    
    override init(name: String){
        super.init(name: name)
        strength = 0
        health = helmet["Diamond"]!
        type = "Colosse"
    }
}
