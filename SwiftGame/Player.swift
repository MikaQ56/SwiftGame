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
    
    // Game is initialized when Player is initialized
    private let game: Game
    
    // Initialize 'Player' class
    init(name: String, game: Game){
        self.name = name
        self.game = game
    }
    
    // Add Character to player's team
    private func addToTeam(character: Character){ team.append(character) }
    
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
        let character = game.ui.editCharacter()
        save(character: character)
    }
    
    private func save(character: Character){
         // Add character on player's team
        addToTeam(character: character)
        // Add character on Game
        game.add(character: character)
        // Confirm success operation
        game.ui.characterCreated(character: character)
    }
    
    func createTeam(){
        var round = 1
        // Create characters while the team count is < 3
        while team.count < 3 {
            game.ui.selectCharacterType(round: round)
            createCharacter()
            round+=1
        }
        // Confirm operation success
        game.ui.teamCreated(name: name)
    }
    
    // Function for Bonus ! Create players'teams automatically
    func createTeamAuto(){
        while team.count < 3 {
            // See function's details below...
            createCharacterAuto()
        }
        // Confirmation
        game.ui.teamCreated(name: name)
    }
    
    // Create character automatically
    private func createCharacterAuto() {
        // Define character's names in an array
        let names = ["Hulk", "Iron man", "Gandalf", "Oz", "Tyrion", "Captain America", "Conan", "Gimli"]
        // Define Integer at random to select in the 'names' array (over)
        var randomIntForNames = Int.random(names.count)
        // Define Integer >= 0 & < 4 to switch character type below
        let randomIntForTypes = Int.random(CharacterType.allCases().count)
        // Check that the name defined at random doesn't exist. Else, select another name at random in 'names' array
        while game.characterNameExists(name: names[randomIntForNames]){
            randomIntForNames = Int.random(names.count)
        }
        // Create character depending the character type selected at random...
        let character = Character.edit(choice: randomIntForTypes, characterName: names[randomIntForNames])
        save(character: character)
    }
    
}

