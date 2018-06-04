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
    
    func run(){
        
        description()
        
        editPlayers()
        
    }
    
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
    
    // Add player to the game
    func add(player: Player){
        
        players.append(player)
    }
    
    // Add character to the game
    func add(character: Character){
        
        characters.append(character)
    }
    
    // Is there an other character with the same name ?
    func characterNameExists(name: String) -> Bool{
        
        for character in characters{
            if character.name == name {
                return true
            }
        }
        return false
    }
    
    // Edit players : players' name & teams...
    func editPlayers(){
        
        // Edit players while players' number max isn't reach
        var index = 0
        while players.count < playersMax{
            
            // Asking player's name...
            print("\nJoueur \(index+1), quel est votre Nom ?")
            if var playerName = readLine(){
                
                // Check that the name is valid..
                while playerName == ""{
                    print("\nVous devez entrer un nom. Saisissez à nouveau...\n")
                    playerName = readLine()!
                }
                
                // If name valid, then Player class is initialized and the player added to the game
                let player = Player(name: playerName)
                add(player: player)
                
                player.createTeam()
                
            }
            
            index+=1
        }
        
        // Confirm creation of the teams
        print("\n******************************************************************\n")
        print("Les joueurs et leurs équipes sont prêts. Passons au combat !")
        print("\n******************************************************************\n")
    }
    
    // Resume the state of players'teams during the game
    func teamsState(){
        
        print("\n------------------------------------------------------------------\n")
        
        // Loop in players' teams to check team's state
        for player in players {
            print("\n*** Etat des troupes de l'équipe de \(player.name) ***\n")
            let teamPlayer = player.team
            
            // Inform when the team is empty
            if teamPlayer.count == 0{
                print("-- Le joueur \(player.name) n'a plus de personnages. Ils sont tous morts !")
            }
                // Give details on team's state
            else{
                var index = 0
                for character in teamPlayer {
                    index+=1
                    if let mage = character as? Mage{
                        print("\(index). \(mage.name), le Mage, a \(mage.health) points de vie et une force de \(mage.strength). Mais il a un super pouvoir. Il peu soigné ses équipiers en leur redonnant \(mage.care) points de vie\n")
                    }
                    else{
                        print("\(index). \(character.name), le \(character.type), a \(character.health) points de vie et une force de \(character.strength)\n")
                    }
                }
            }
        }
        print("\n------------------------------------------------------------------\n")
    }
    
}
