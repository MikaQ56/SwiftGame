//
//  Player.swift
//  SwiftGame
//
//  Created by Mickael on 04/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Create 'Player' class to manage game's players
class Player {
    
    // Player's name
    let name: String
    
    // Player's team. Array of 'Character' type
    var team = [Character]()
    
    // Initialize 'Player' class
    init(name: String){
        self.name = name
    }
    
    // Add Character player's team
    private func add(character: Character){
        team.append(character)
    }
    
    // Remove character from player's team
    func delete(characterName: String){
        var index = 0
        for character in team{
            if character.name == characterName{
                team.remove(at: index)
            }
            index+=1
        }
    }
    
    // Edit a Character, return boolean value depending success of operation
    private func createCharacter(){
        
        if let choice = readLine(){
            
            let choiceAsInt = game.check(choice: choice, choiceMax: 4)
            
            print("\nQuel sera son nom ?")
            
            if var characterName = readLine(){
                
                // Check character'name typed by player
                while characterName == "" {
                    
                    Style.separatorForFlash()
                    print("Vous devez donner un nom à votre personnage ! Entrez un nom :")
                    Style.separatorForFlash()
                    characterName = readLine()!
                }
                
                // Is there already character with the same name ?
                while game.characterNameExists(name: characterName){
                    
                    Style.separatorForFlash()
                    print("Ce nom existe déjà dans la partie. Choisissez un autre nom :")
                    Style.separatorForFlash()
                    characterName = readLine()!
                }
                
                let character = CharacterType.edit(choice: choiceAsInt, characterName: characterName)
                save(character: character)
            }
        }
    }
    
    private func save(character: Character){
        
         // Add character on player's team
        add(character: character)
        
        // Add character on Game
        game.add(character: character)
        
        // Confirm success operation
        print("\n\(character.name), \(character.type), a bien été ajouté à votre équipe.")
    }
    
    func createTeam(){
        
        var round = 1
        
        // Create characters while the team count is < 3
        while team.count < 3 {
            
            
            switch round{
            case 1:
                print("\nChoisissez le premier personnage à intégrer votre équipe (donnez le chiffre associé au personnage) :\n")
            case 2:
                print("\nChoisissez le deuxieme personnage à intégrer votre équipe (donnez le chiffre associé au personnage) :\n")
            case 3:
                print("\nChoisissez le dernier personnage à intégrer votre équipe (donnez le chiffre associé au personnage) :\n")
            default:
                print("Personnages edités")
            }
            
            createCharacter()
            round+=1
        }
        
        // Confirm operation success
        Style.separatorForFlash()
        print("\(name), votre équipe est constituée !")
        Style.separatorForFlash()
    }
    
    // Function for Bonus ! Create players'teams automatically
    func createTeamAuto(){
        
        while team.count < 3 {
            
            // See function's details below...
            createCharacterAuto()
            
        }
        
        // Confirmation
        Style.separatorForFlash()
        print("\(name), votre équipe est constituée !")
        Style.separatorForFlash()
    }
    
    // Create character automatically
    private func createCharacterAuto() {
        
        // Define character's names in an array
        let names = ["Hulk", "Iron man", "Gandalf", "Oz", "Tyrion", "Captain America", "Conan", "Gimli"]
        
        // Define Integer at random to select in the 'names' array (over)
        var randomIntForNames = Int(arc4random_uniform(UInt32(names.count)))
        
        // Define Integer >= 0 & < 4 to switch character type below
        let randomIntForTypes = Int(arc4random_uniform(UInt32(4)))
        
        // Check that the name defined at random doesn't exist. Else, select another name at random in 'names' array
        while game.characterNameExists(name: names[randomIntForNames]){
            randomIntForNames = Int(arc4random_uniform(UInt32(names.count)))
        }
        
        // Create character depending the character type selected at random...
        switch randomIntForTypes{
        case 0:
            let fighter = Fighter(name: names[randomIntForNames])
            save(character: fighter)
        case 1:
            let magus = Magus(name: names[randomIntForNames])
            save(character: magus)
        case 2:
            let colossus = Colossus(name: names[randomIntForNames])
            save(character: colossus)
        case 3:
            let dwarf = Dwarf(name: names[randomIntForNames])
            save(character: dwarf)
        default:
            print("\nLe personnage que vous avez choisi n'existe pas.")
        }
        
    }
    
}

