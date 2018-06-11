//
//  UI.swift
//  SwiftGame
//
//  Created by Mickael on 11/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

protocol UI {
    
    func introduction()
    
    func startCreateTeams()
    
    func playerName(number: Int)
    
    func playerNameEmpty()
    
    func playersReady()
    
    func teamState(to player: Player)
    
    func teamPlayerIsDead(from player: Player )
    
    func startFight()
    
    func selectCharacter(from player: Player)
    
    func selectOpponentCharacter()
    
    func gameIsOver(winner: String, rounds: Int)
    
    func wrongNumber(numberMax: Int)
    
    func isNotNumber()
    
    func carePowerIncrease(care: Int)
    
    func newWeapon(strength: Int)
    
    func characterName()
    
    func characterNameEmpty()
    
    func characterNameExists()
    
    func characterCreated(character: Character)
    
    func teamCreated(name: String)
    
}

