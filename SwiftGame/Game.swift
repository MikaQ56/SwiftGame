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
    var players = [Player]()
    
    // Players' max number in the game
    var playersMax = 2
    
    // Characters created by players to set up their teams
    var characters = [Character]()
    
    // List of character types
    var characterTypes = ["Le Combattant", "Le Mage", "Le Colosse", "Le Nain"]
    
    // When the game is over, then the variable 'gameOver' is true
    var gameOver = false
    
    // Rounds' number in the game. Initialized to 0 at the beginning
    var rounds = 0
    
    // Winner's name
    var winner = String()
    
    // If players want to create teams automatically
    var modeAuto = false
    
    // Game running
    func run(){
        
        description()
        
        editPlayers()
        
        start()
    }
    
    // Function for developpement mode...
    func editPlayersAuto(){
        
        let player1 = Player(name: "Mickael")
        let player2 = Player(name: "Nicolas")
        
        add(player: player1)
        add(player: player2)
        
        player1.team.append(Combattant(name: "Thor"))
        player1.team.append(Mage(name: "Oz"))
        player1.team.append(Colosse(name: "Hulk"))
        
        player2.team.append(Combattant(name: "Ryan"))
        player2.team.append(Mage(name: "Gandalf"))
        player2.team.append(Nain(name: "Tyrion"))
        
    }
    
    // Introduction of the game at the beginning
    func description(){
        
        print("Bienvenue dans SwiftGame ! Un jeu dans lequel deux équipes vont s'affronter dans un combat à mort. Entrez dans l'arene...\n")
        print("Chaque joueur devra constituer une équipe avec 3 personnages...\n")
        print("Voici les personnages existants, et que vous pourrez choisir avec leur numéro :\n")
        
        // List of character types
        for (index, characterType) in characterTypes.enumerated() {
            print("\(index+1). "+characterType+"\n")
        }
        
        print("Chaque personnage a des caractéristiques différentes...\n")
        print("Vous voulez en savoir plus ? Commencons par constituer les équipes !\n")
        print("Souhaitez vous que les équipes soit créées automatiquement ou préférez vous le faire vous même ?\n1. Tapez 1 pour le mode Auto\n2. Tapez 2 pour le mode manuel")
        
        // Option for automatic mode...
        if let choice = readLine(){
            let choiceAsInt = check(choice: choice, choiceMax: 2)
            if choiceAsInt == 1 {
                modeAuto = true
            }
        }
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
            if teamPlayer.isEmpty{
                print("-- Le joueur \(player.name) n'a plus de personnages. Ils sont tous morts !")
            }
                // Give details on team's state
            else{
                
                for (index, character) in teamPlayer.enumerated() {
                    
                    if let mage = character as? Mage{
                        print("\(index+1). \(mage.name), le Mage, a \(mage.health) points de vie et une force de \(mage.strength). Mais il a un super pouvoir. Il peu soigné ses équipiers en leur redonnant \(mage.care) points de vie\n")
                    }
                    else{
                        print("\(index+1). \(character.name), le \(character.type), a \(character.health) points de vie et une force de \(character.strength)\n")
                    }
                }
            }
        }
        print("\n------------------------------------------------------------------\n")
    }
    
    // Start the fight !
    func start(){
        
        // Recall teams' state
        teamsState()
        
        print("\n******************************************************************\n")
        print("Il est temps de rentrer dans l'ârene !")
        print("\n******************************************************************\n")
        
        // The game will be finished when the variable 'gameOver' is true
        while !gameOver{
            
            for (index, player) in players.enumerated() {
                
                var team = player.team
                
                // Step 1 : Select one character in the player's team
                print("\(player.name), choisissez un personnage de votre équipe :")
                if let choice = readLine(){
                    
                    let choiceAsInt = check(choice: choice, choiceMax: team.count)
                    
                    // If first choice is ok, then provide a random step...
                    // Step 2 : Run at random... See runStep2AtRandom function details below
                    runStep2AtRandom(choice: choiceAsInt, team: team, index: index)
                        
                    // Step 3 : Select the opponent character...
                    print("\(player.name), choisissez une cible dans l'équipe adverse ou un personnage de votre équipe si vous venez de sélectionner un Mage :")
                        
                    // Check the number selected to choose the character
                    if let targetIndex = readLine(){
                            
                        let targetAsInt = check(choice: targetIndex, choiceMax: team.count)
                                
                        // Manage interactions between characters : results of strength, health points...
                                
                        // Separate Mage's case
                        if let mage = team[choiceAsInt-1] as? Mage{
                                    
                            mage.care(target: player.team[targetAsInt-1])
                                    
                            // Initialized Mage's care property in case "step 2 optional" (see previously over) has been accomplished...
                            mage.care = 20
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
        print("\n******************************************************************\n")
        print("Partie finie ! Le joueur \(winner) a gagné. Nombre de tours effectués : \(rounds)")
        print("\n******************************************************************\n")
    }
    
    func fight(index: Int, team: [Character], targetAsInt: Int, choiceAsInt: Int, player: Player){
        
        var targetCharacter: Character
        var targetPlayer: Player
        
        if index == 0 {
            
            targetPlayer = players[index+1]
        }
        else{
            
            targetPlayer = players[0]
        }
        
            
        // Save, implement action... See 'strike' function in 'Player' class for more details
        targetCharacter = targetPlayer.team[targetAsInt-1]
        team[choiceAsInt-1].strike(target: targetCharacter, player: targetPlayer)
            
        // All player's characters are dead
        if targetPlayer.team.isEmpty{
                
            // The game is over
            gameOver = true
                
            // Save the winner's name
            winner = player.name
        }

    // Initialized character's strength points default in case "step 2 optional" (see previously over) has been accomplished...
        
        initalizeStrengthProperty(choiceAsInt: choiceAsInt, team: team)
        
    }
    
    func initalizeStrengthProperty(choiceAsInt: Int, team: [Character]){
        
        if let combattant = team[choiceAsInt-1] as? Combattant{
            
            combattant.strength = Box.Weapon.dagger.rawValue
            
        }
        
        if let colosse = team[choiceAsInt-1] as? Colosse{
            
            colosse.strength = Box.Weapon.noWeapon.rawValue
            
        }
        
        if let nain = team[choiceAsInt-1] as? Nain{
            
            nain.strength = Box.Weapon.axe.rawValue
            
        }
    }
    
    func check(choice: String, choiceMax: Int) -> Int {
        
        if var choiceAsInt = Int(choice){
            
            // Check the number selected by player to choose a character in team
            while choiceAsInt < 1 || choiceAsInt > choiceMax{
                print("Vous devez choisir un chiffre entre 1 et \(choiceMax)")
                let newChoice = readLine()!
                if let newChoice = Int(newChoice){
                    choiceAsInt = newChoice
                }
            }
            
            return choiceAsInt
        }
        else{
            
            print("Vous devez saisir un chiffre !")
            let newChoice = readLine()!
            let choiceAsInt = check(choice: newChoice, choiceMax: choiceMax)
            return choiceAsInt
        }
    }
    
    func runStep2AtRandom(choice: Int, team: [Character], index: Int){
        
        // Save a number >= 1 & < 8 at random.
        var random = Int(arc4random_uniform(7))
        
        // Step 2 : Optional...
        // If this number (random) is equal to the loop'index then the player retrieves a weapon or 'carePower' in the game'box
        // See emum Box in Box.swift file
        if random == index {
            
            //  Mage character's case. The 'care power' is increased at random. Different levels : 'strong', 'very strong', 'super strong'. See the enum CarePower in Box.swift file
            if let mage = team[choice-1] as? Mage{
                if random > 3 {
                    random -= 4
                }
                
                // See the 'carePower' function details below
                let carePowerAtRandom = carePower(atRandom: random)
                
                // Mage's power is increased
                mage.care = carePowerAtRandom.rawValue
                print("Le Mage a gagné de l'expérience ! Il peut soigner jusqu'à \(carePowerAtRandom.rawValue) ")
            }
                // Other characters. Strength can be increase or decrease.. Depend of the weapon find in the box !
            else{
                
                // See the 'carePower' function details below
                let weaponAtRandom = weapon(atRandom: random)
                team[choice-1].strength = weaponAtRandom.rawValue
                print("Vous avez une nouvelle arme ! Qui vous donne une force de \(weaponAtRandom.rawValue) ")
            }
        }
    }
    
    // Select a weapon at random in box
    func weapon(atRandom number: Int) -> Box.Weapon {
        
        // Switch with "Weapons" enum. See Box.swift file for more details on Weapons enum...
        switch number {
            
        case 1:
            return .sword
        case 2:
            return .lance
        case 3:
            return .dagger
        case 4:
            return .bow
        case 5:
            return .axe
        case 6:
            return .gun
        default:
            return .noWeapon
            
        }
    }
    
    // Select a 'carePower' at random in box
    func carePower(atRandom number: Int) -> Box.CarePower {
        
        // Switch with "Weapons" enum. See Box.swift file for more details on Weapons enum...
        switch number {
            
        case 1:
            return .strong
        case 2:
            return .veryStrong
        default:
            return .superStrong
            
        }
    }
}

