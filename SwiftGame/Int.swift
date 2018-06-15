//
//  Int.swift
//  SwiftGame
//
//  Created by Mickael on 15/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

extension Int {
    static func random(_ number: Int) -> Int {
        return Int(arc4random_uniform(UInt32(number)))
    }
}
