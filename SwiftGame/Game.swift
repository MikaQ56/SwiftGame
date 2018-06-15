//
//  Game.swift
//  SwiftGame
//
//  Created by Mickael on 04/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Create a 'Game' class to manage the game (parameters, rules, running...)
class Game{
    
    // Players in the game...
    private var players = [Player]()
    
    // Players' max number in the game
    private let playersMax = 2
    
    // Characters created by players to set up their teams
    private var characters = [Character]()
    
    // List of character types
    private let characterTypes: [CharacterType]
    
    // When the game is over, then the variable 'gameOver' is true
    private var gameOver = false
    
    // Rounds' number in the game. Initialized to 0 at the beginning
    private var rounds = 0
    
    // Winner's name
    private var winner = String()
    
    // If players want to create teams automatically
    private var modeAuto = false
    
    let ui: UI
    
    init(characterTypes: [CharacterType], ui: UI ) {
        
        self.characterTypes = characterTypes
        self.ui = ui
    }
    
    // Game running
    func run(){
        
        introduction()
        
        editPlayers()
        
        start()
    }
    
    
    // Introduction of the game at the beginning
    private func introduction(){
        
        // Display introduction message
        ui.displayIntroductionMessage()
        
        // Character types' list
        ui.listCharactersAvailable(from: characterTypes)
        
        // Let's create teams
        ui.startCreateTeams()
        
        // Option for automatic mode...
        modeAuto = ui.selectAutoMode()
    }
    
    // Add player to the game
    func add(player: Player){ players.append(player) }
    
    // Add character to the game
    func add(character: Character){ characters.append(character) }
    
    // Is there an other character with the same name in the game ?
    func characterNameExists(name: String) -> Bool{
        
        for character in characters{
            if character.name == name {
                return true
            }
        }
        return false
    }
    
    // Edit players : players' name & teams...
    private func editPlayers(){
        
        // Edit players while players'number max isn't reach
        var index = 0
        while players.count < playersMax{
            
            // Asking player's name...
            ui.askPlayerName(number: index)
            
            // Edit player's name. If player's name format is ok, then Player is initialized & added to the game
            let player = ui.editPlayerName()
            add(player: player)
                
            // Check automatic mode before create teams
            if modeAuto {
                player.createTeamAuto()
            }
            else{
                player.createTeam()
            }
    
            index+=1
        }
        
        // Confirm creation of the teams
        ui.playersAreReady()
    }
    
    
    // Start the fight !
    private func start(){
        
        // Recall teams' state
        ui.displayTeamsState(players: players)
        
        ui.startFight()
        
        // The game will be finished when the variable 'gameOver' is true
        while !gameOver{
            
            for (index, player) in players.enumerated() {
                
                
                // Step 1 : Select one character in the player's team
                let characterPicked = ui.selectCharacter(from: player)
                
                // Step 2 : Run at random... See runStep2AtRandom function details below
                runStep2AtRandom(characterPicked: characterPicked, index: index)
                        
                // Step 3 : Select the opponent character...
                let characterOpponentPicked = ui.selectOpponentCharacter(players: players, index: index)
                
                // Step 4 : fight !
                // Manage interactions between characters : results of strength, health points...
                // Separate Mage's case
                if let magus = characterPicked as? Magus{
                                    
                    magus.care(target: characterOpponentPicked)
                                    
                    // Initialized Mage's care property in case "step 2 optional" (see previously over) has been accomplished...
                    magus.care = 20
                }
                else{
                            
                    fight(index: index, characterOpponentPicked: characterOpponentPicked, characterPicked: characterPicked, player: player)
                }
            }
            
            // Inform on teams'state
            ui.displayTeamsState(players: players)
                
            // Count the rounds' number
            rounds+=1
        }
        
        ui.gameIsOver(winner: winner, rounds: rounds)
    }
    
    
    // Manage fight between Player's characters
    private func fight(index: Int, characterOpponentPicked: Character, characterPicked: Character, player: Player){
        
        var targetPlayer: Player
        
        // The target Player depends of loop's index
        if index == 0 { targetPlayer = players[index+1] }
        else{ targetPlayer = players[0] }
        
        // Save, implement action... See 'strike' function in 'Player' class for more details
        
        characterPicked.strike(target: characterOpponentPicked, player: targetPlayer)
            
        // If all player's characters are dead
        if targetPlayer.team.count == 0{
                
            // The game is over
            gameOver = true
                
            // Save the winner's name
            winner = player.name
        }

    // Initialized character's strength points default in case "step 2 optional" (see previously over) has been accomplished...
        
        initalizeStrengthProperty(characterPicked: characterPicked)
        
    }
    
    private func initalizeStrengthProperty(characterPicked: Character){
        
        if let fighter = characterPicked as? Fighter{ fighter.strength = Box.Weapon.dagger.damage() }
        
        if let colossus = characterPicked as? Colossus{ colossus.strength = Box.Weapon.lance.damage() }
        
        if let dwarf = characterPicked as? Dwarf{ dwarf.strength = Box.Weapon.axe.damage() }
    }
    
    
    
    private func runStep2AtRandom(characterPicked: Character, index: Int){
        
        // Save a number >= 0 & < 6 at random.
        var random = Int.random(6)
        
        // Step 2 : Optional...
        // If this number (random) is equal to the loop'index then the player retrieves a weapon or 'carePower' in the game'box
        // See emum Box in Box.swift file
        if random == index {
            
            //  Mage character's case. The 'care power' is increased at random. Different levels : 'strong', 'very strong', 'super strong'. See the enum CarePower in Box.swift file
            if let mage = characterPicked as? Magus{
                if random > 2 { random -= 3 }
                
                // See the 'carePower' function details below
                let carePowerAtRandom = Box.CarePower.random()
                
                // Mage's power is increased
                mage.care = carePowerAtRandom.care()
                ui.increaseCarePower(care: mage.care)
            }
            // Other characters. Strength can be increase or decrease.. Depend of the weapon find in the box !
            else{
                
                // See the 'carePower' function details below
                let weaponAtRandom = Box.Weapon.random()
                characterPicked.strength = weaponAtRandom.damage()
                ui.newWeapon(strength: characterPicked.strength)
            }
        }
    }
    
    
    // Function for developpement mode...
    private func editPlayersAuto(){
        
        let player1 = Player(name: "Mickael")
        let player2 = Player(name: "Nicolas")
        
        add(player: player1)
        add(player: player2)
        
        player1.team.append(Fighter(name: "Thor"))
        player1.team.append(Magus(name: "Oz"))
        player1.team.append(Colossus(name: "Hulk"))
        
        player2.team.append(Fighter(name: "Ryan"))
        player2.team.append(Magus(name: "Gandalf"))
        player2.team.append(Dwarf(name: "Tyrion"))
        
    }
}

