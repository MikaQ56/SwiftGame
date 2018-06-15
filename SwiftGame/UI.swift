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
    
    func editPlayerName() -> Player
    
    func playerNameIsEmpty()
    
    func playersAreReady()
    
    func displayTeamsState(players: [Player])
    
    func startFight()
    
    func selectCharacter(from player: Player) -> Character
    
    func selectOpponentCharacter(players: [Player], index: Int) -> Character
    
    func gameIsOver(winner: String, rounds: Int)
    
    func wrongNumber(numberMax: Int)
    
    func isNotNumber()
    
    func increaseCarePower(care: Int)
    
    func newWeapon(strength: Int)
    
    func askCharacterName()
    
    func characterNameEmpty()
    
    func characterNameExists()
    
    func characterCreated(character: Character)
    
    func teamCreated(name: String)
    
    func check(choice: String, choiceMax: Int) -> Int
    
}

