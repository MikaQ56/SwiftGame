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
        
        description()
        
        editPlayers()
        
        start()
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
    
    // Introduction of the game at the beginning
    private func description(){
        
        ui.introduction()
        
        // List of character types
        for (index, characterType) in characterTypes.enumerated() {
            print("\(index+1). "+characterType.description()+"\n")
        }
        
        ui.startCreateTeams()
        
        // Option for automatic mode...
        if let choice = readLine(){
            let choiceAsInt = check(choice: choice, choiceMax: 2)
            if choiceAsInt == 1 {
                modeAuto = true
            }
        }
    }
    
    // Add player to the game
    private func add(player: Player){
        
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
    private func editPlayers(){
        
        // Edit players while players' number max isn't reach
        var index = 0
        while players.count < playersMax{
            
            // Asking player's name...
            ui.playerName(number: index)
            if var playerName = readLine(){
                
                // Check that the name is valid..
                while playerName == ""{
                    
                    ui.playerNameEmpty()
                    playerName = readLine()!
                }
                
                // If name valid, then Player class is initialized and the player added to the game
                let player = Player(name: playerName)
                add(player: player)
                
                // Check automatic mode before create teams
                if modeAuto {
                    player.createTeamAuto()
                }
                else{
                    player.createTeam()
                }
                
            }
            
            index+=1
        }
        
        // Confirm creation of the teams
        ui.playersReady()
    }
    
    // Resume the state of players'teams during the game
    private func teamsState(){
        
        Style.separatorForTeamState()
        
        // Loop in players' teams to check team's state
        for player in players {
            ui.teamState(to: player)
            let teamPlayer = player.team
            
            // Inform when the team is empty
            if teamPlayer.isEmpty{
                ui.teamPlayerIsDead(from: player)
            }
                // Give details on team's state
            else{
                
                for (index, character) in teamPlayer.enumerated() {
                    
                    if let mage = character as? Magus{
                        print("\(index+1).")
                        mage.introduction()
                    }
                    else{
                        print("\(index+1).")
                        character.introduction()
                    }
                }
            }
        }
        Style.separatorForTeamState()
    }
    
    // Start the fight !
    private func start(){
        
        // Recall teams' state
        teamsState()
        
        ui.startFight()
        
        // The game will be finished when the variable 'gameOver' is true
        while !gameOver{
            
            for (index, player) in players.enumerated() {
                
                var team = player.team
                
                // Step 1 : Select one character in the player's team
                ui.selectCharacter(from: player)
                if let choice = readLine(){
                    
                    let choiceAsInt = check(choice: choice, choiceMax: team.count)
                    
                    // If first choice is ok, then provide a random step...
                    // Step 2 : Run at random... See runStep2AtRandom function details below
                    runStep2AtRandom(choice: choiceAsInt, team: team, index: index)
                        
                    // Step 3 : Select the opponent character...
                    ui.selectOpponentCharacter()
                        
                    // Check the number selected to choose the character
                    if let targetIndex = readLine(){
                        
                        var teamPlayer: [Character]
                        if index == 0{
                            
                            teamPlayer = players[1].team
                        }
                        else{
                            
                            teamPlayer = players[0].team
                        }
                            
                        let targetAsInt = check(choice: targetIndex, choiceMax: teamPlayer.count)
                                
                        // Manage interactions between characters : results of strength, health points...
                        // Separate Mage's case
                        if let magus = team[choiceAsInt-1] as? Magus{
                                    
                            magus.care(target: player.team[targetAsInt-1])
                                    
                            // Initialized Mage's care property in case "step 2 optional" (see previously over) has been accomplished...
                            magus.care = 20
                        }
                        else{
                            
                            fight(index: index, team: team, targetAsInt: targetAsInt, choiceAsInt: choiceAsInt, player: player)
                        }
                    }
                }
                
                // Inform on teams'state
                teamsState()
                
                // Count the rounds' number
                rounds+=1
            }
        }
        
        ui.gameIsOver(winner: winner, rounds: rounds)
    }
    
    
    // Manage fight between Player's characters
    private func fight(index: Int, team: [Character], targetAsInt: Int, choiceAsInt: Int, player: Player){
        
        var targetCharacter: Character
        var targetPlayer: Player
        
        // The target Player depends of loop's index
        if index == 0 {
            
            targetPlayer = players[index+1]
        }
        else{
            
            targetPlayer = players[0]
        }
        
        // Save, implement action... See 'strike' function in 'Player' class for more details
        targetCharacter = targetPlayer.team[targetAsInt-1]
        team[choiceAsInt-1].strike(target: targetCharacter, player: targetPlayer)
            
        // If all player's characters are dead
        if targetPlayer.team.count == 0{
                
            // The game is over
            gameOver = true
                
            // Save the winner's name
            winner = player.name
        }

    // Initialized character's strength points default in case "step 2 optional" (see previously over) has been accomplished...
        
        initalizeStrengthProperty(choiceAsInt: choiceAsInt, team: team)
        
    }
    
    private func initalizeStrengthProperty(choiceAsInt: Int, team: [Character]){
        
        if let fighter = team[choiceAsInt-1] as? Fighter{
            
            fighter.strength = Box.Weapon.dagger.damage()
            
        }
        
        if let colossus = team[choiceAsInt-1] as? Colossus{
            
            colossus.strength = Box.Weapon.lance.damage()
            
        }
        
        if let dwarf = team[choiceAsInt-1] as? Dwarf{
            
            dwarf.strength = Box.Weapon.axe.damage()
            
        }
    }
    
    func check(choice: String, choiceMax: Int) -> Int {
        
        if var choiceAsInt = Int(choice){
            
            // Check the number selected by player to choose a character in team
            while choiceAsInt < 1 || choiceAsInt > choiceMax{
                
                ui.wrongNumber(numberMax: choiceMax)
                
                let newChoice = readLine()!
                if let newChoice = Int(newChoice){
                    choiceAsInt = newChoice
                }
            }
            
            return choiceAsInt
        }
        else{
            
            ui.isNotNumber()
            
            let newChoice = readLine()!
            let choiceAsInt = check(choice: newChoice, choiceMax: choiceMax)
            return choiceAsInt
        }
    }
    
    private func runStep2AtRandom(choice: Int, team: [Character], index: Int){
        
        // Save a number >= 0 & < 6 at random.
        var random = Int(arc4random_uniform(6))
        
        // Step 2 : Optional...
        // If this number (random) is equal to the loop'index then the player retrieves a weapon or 'carePower' in the game'box
        // See emum Box in Box.swift file
        if random == index {
            
            //  Mage character's case. The 'care power' is increased at random. Different levels : 'strong', 'very strong', 'super strong'. See the enum CarePower in Box.swift file
            if let mage = team[choice-1] as? Magus{
                if random > 2 {
                    random -= 3
                }
                
                // See the 'carePower' function details below
                let carePowerAtRandom = carePower(atRandom: random)
                
                // Mage's power is increased
                mage.care = carePowerAtRandom
                ui.carePowerIncrease(care: carePowerAtRandom)
            }
                // Other characters. Strength can be increase or decrease.. Depend of the weapon find in the box !
            else{
                
                // See the 'carePower' function details below
                let weaponAtRandom = weapon(atRandom: random)
                team[choice-1].strength = weaponAtRandom
                ui.newWeapon(strength: weaponAtRandom)
            }
        }
    }
    
    // Select a weapon at random in box
    private func weapon(atRandom number: Int) -> Int{
        
        if let choice = Box.Weapon(rawValue: number){
            
            switch choice {
                
            case .sword:
                return Box.Weapon.sword.damage()
            case .lance:
                return Box.Weapon.lance.damage()
            case .dagger:
                return Box.Weapon.dagger.damage()
            case .bow:
                return Box.Weapon.bow.damage()
            case .axe:
                return Box.Weapon.axe.damage()
            case .gun:
                return Box.Weapon.gun.damage()
            }
        }
        else{
            
            return 0
        }
    }
    
    // Select a 'carePower' at random in box
    private func carePower(atRandom number: Int) -> Int{
        
        if let choice = Box.CarePower(rawValue: number){
            
            switch choice {
                
            case .strong:
                return Box.CarePower.strong.care()
            case .veryStrong:
                return Box.CarePower.veryStrong.care()
            case .superStrong:
                return Box.CarePower.superStrong.care()
            }
        }
        else{
            
            return 0
        }
    }
}

