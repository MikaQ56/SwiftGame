//
//  Style.swift
//  SwiftGame
//
//  Created by Mickael on 06/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Class to manage style in terminal
class Style {
    
    // Separator line for flash message from the terminal
    static func separatorForFlash(){
        
       print("\n**************************************************************************************************\n")
    }
    
    // Separator to print team state
    static func separatorForTeamState(){
        
       print("\n--------------------------------------------------------------------------------------------------\n")
    }
}
