//
//  Game.swift
//  SwiftGame
//
//  Created by Mickael on 04/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Create a 'Game' class to manage the game (parameters, rules, running...)
class Game {
    
    // Players in the game...
    var players = [Player]()
    
    // Players' max number in the game
    var playersMax = 2
    
    // Characters created by players to set up their teams
    var characters = [Character]()
    
    // List of character types
    var characterTypes = ["Le Combattant", "Le Mage", "Le Colosse", "Le Nain"]
    
    // Introduction of the game at the beginning
    func description(){
        
        print("Bienvenue dans PlayGame ! Un jeu dans lequel deux équipes vont s'affronter dans un combat à mort. Entrez dans l'arene...\n")
        print("Chaque joueur devra constituer une équipe avec 3 personnages...\n")
        print("Voici les personnages existants, et que vous pourrez choisir avec leur numéro :\n")
        
        // List of character types
        var index = 0
        for characterType in characterTypes {
            index+=1
            print("\(index). "+characterType+"\n")
        }
        
        print("Chaque personnage a des caractéristiques différentes...\n")
        print("Vous voulez en savoir plus ? Commencons par constituer les équipes !\n")
        print("Souhaitez vous que les équipes soit créées automatiquement ou préférez vous le faire vous même ?\n1. Tapez 1 pour le mode Auto\n2. Tapez 2 pour le mode manuel")
        
        
    }
    
}
