//
//  UI.swift
//  SwiftGame
//
//  Created by Mickael on 11/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

protocol UI {
    
    func displayIntroductionMessage()
    
    func listCharactersAvailable(from characterTypes: [CharacterType])
    
    func startCreateTeams()
    
    func selectAutoMode() -> Bool
    
    func askPlayerName(number: Int)
    
    func editPlayerName() -> String
    
    func playersAreReady()
    
    func displayTeamsState(players: [Player])
    
    func startFight()
    
    func selectCharacter(from player: Player) -> Character
    
    func selectCharacterToCare(players: [Player], index: Int) -> Character
    
    func selectOpponentCharacter(players: [Player], index: Int) -> Character
    
    func gameIsOver(winner: String, rounds: Int)
    
    func increaseCarePower(care: Int)
    
    func newWeapon(strength: Int)
    
    func selectCharacterType(round: Int)
    
    func editCharacter() -> Character 
    
    func characterCreated(character: Character)
    
    func teamCreated(name: String)
    
    func introduceCharacter(message: String)
    
    func displayFightResult(message: String)
    
    func displayCareResult(message: String)

    func displayCarePower(message: String)
    
    func characterIsDead(message: String)
    
}

