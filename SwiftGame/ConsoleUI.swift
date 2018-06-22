//
//  ConsoleUI.swift
//  SwiftGame
//
//  Created by Mickael on 11/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation


class ConsoleUI: UI {
    
    func displayIntroductionMessage() {
        print("Bienvenue dans SwiftGame ! Un jeu dans lequel deux équipes vont s'affronter dans un combat à mort. Entrez dans l'arene...\n")
        print("Chaque joueur devra constituer une équipe avec 3 personnages...\n")
        print("Voici les personnages existants, et que vous pourrez choisir avec leur numéro :\n")
    }
    
    func listCharactersAvailable(from characterTypes: [CharacterType]) {
        for (index, characterType) in characterTypes.enumerated() {
            print("\(index+1). "+characterType.description()+"\n")
        }
    }
    
    func startCreateTeams() {
        print("Chaque personnage a des caractéristiques différentes...\n")
        print("Vous voulez en savoir plus ? Commencons par constituer les équipes !\n")
        print("Souhaitez vous que les équipes soit créées automatiquement ou préférez vous le faire vous même ?\n\n1. Tapez 1 pour le mode Auto\n\n2. Tapez 2 pour le mode manuel\n")
    }
    
    func selectAutoMode() -> Bool {
        if let choice = readLine(){
            let choiceAsInt = check(choice: choice, choiceMax: 2)
            if choiceAsInt == 1 {
                return true
            }
        }
        return false
    }
    
    func askPlayerName(number: Int) {
        print("\nJoueur \(number+1), quel est votre Nom ?")
    }
    
    func editPlayerName() -> String {
        var playerName = readLine()!
        // Check that the name is valid..
        while playerName == ""{
            playerNameIsEmpty()
            playerName = readLine()!
        }
        return playerName
    }
    
    func playersAreReady() {
        Style.separatorForFlash()
        print("Les joueurs et leurs équipes sont prêts. Passons au combat !")
        Style.separatorForFlash()
    }
    
    func displayTeamsState(players: [Player]) {
        Style.separatorForTeamState()
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

    func startFight() {
        Style.separatorForFlash()
        print("Il est temps de rentrer dans l'ârene !")
        Style.separatorForFlash()
    }
    
    func selectCharacter(from player: Player) -> Character {
        print("A toi de jouer \(player.name) !\n")
        print("Choisis un personnage de ton équipe :\n")
        let choice = readLine()!
        let choiceAsInt = check(choice: choice, choiceMax: player.team.count)
        return player.team[choiceAsInt-1]
    }
    
    func selectCharacterToCare(players: [Player], index: Int) -> Character {
        print("Choisis un personnage de ton équipe que tu souhaites soigner :\n")
        let targetIndex = readLine()!
        var teamPlayer = players[index].team
        let targetAsInt = check(choice: targetIndex, choiceMax: teamPlayer.count)
        return teamPlayer[targetAsInt-1]
    }
    
    func selectOpponentCharacter(players: [Player], index: Int) -> Character {
        print("Choisis une cible dans l'équipe adverse :\n")
        let targetIndex = readLine()!
        var teamPlayer: [Character]
        if index == 0{ teamPlayer = players[1].team }
        else{ teamPlayer = players[0].team }
        let targetAsInt = check(choice: targetIndex, choiceMax: teamPlayer.count)
        return teamPlayer[targetAsInt-1]
    }
    
    func gameIsOver(winner: String, rounds: Int) {
        Style.separatorForFlash()
        print("Partie finie ! Bravo \(winner), vous avez gagné. Nombre de tours effectués : \(rounds)")
        Style.separatorForFlash()
    }
    
    func increaseCarePower(care: Int) {
        Style.separatorForFlash()
        print("Le Mage a gagné de l'expérience ! Il peut soigner jusqu'à \(care) \n")
        Style.separatorForFlash()
    }
    
    func newWeapon(strength: Int) {
        Style.separatorForFlash()
        print("Tu as une nouvelle arme pour ce tour ! Qui te donne une force de \(strength)")
        Style.separatorForFlash()
    }
    
    func selectCharacterType(round: Int) {
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
    }
    
    func editCharacter() -> Character {
        let choice = readLine()!
        let choiceAsInt = check(choice: choice, choiceMax: CharacterType.allCases().count)
        let characterName = askCharacterName()
        let character = Character.edit(choice: choiceAsInt, characterName: characterName)
        return character
    }
    
    func teamCreated(name: String) {
        Style.separatorForFlash()
        print("\(name), votre équipe est constituée !")
        Style.separatorForFlash()
    }
    
    func characterCreated(character: Character) {
        print("\n\(character.name), \(character.type!.description()), a bien été ajouté à votre équipe.")
    }
    
    func introduceCharacter(message: String) {
        print(message)
    }
    
    func displayFightResult(message: String) {
        Style.separatorForFlash()
        print(message)
        Style.separatorForFlash()
    }
    
    func displayCareResult(message: String) {
        Style.separatorForFlash()
        print(message)
        Style.separatorForFlash()
    }
    
    func characterIsDead(message: String) {
        Style.separatorForFlash()
        print(message)
        Style.separatorForFlash()
    }
    
    func displayCarePower(message: String) {
        print(message)
    }
}

extension ConsoleUI {
    
    private func playerNameIsEmpty() {
        Style.separatorForFlash()
        print("\nVous devez entrer un nom. Saisissez à nouveau...\n")
        Style.separatorForFlash()
    }
    
    private func characterNameExists() {
        Style.separatorForFlash()
        print("Ce nom existe déjà dans la partie. Choisissez un autre nom :")
        Style.separatorForFlash()
    }
    
    private func askCharacterName() -> String {
        print("\nQuel sera son nom ?")
        var characterName = readLine()!
        // Check character'name typed by player
        while characterName == "" {
            characterNameEmpty()
            characterName = readLine()!
        }
        // Is there already character with the same name ?
        while game.characterNameExists(name: characterName){
            characterNameExists()
            characterName = readLine()!
        }
        return characterName
    }
    
    private func characterNameEmpty() {
        Style.separatorForFlash()
        print("Vous devez donner un nom à votre personnage ! Entrez un nom :")
        Style.separatorForFlash()
    }
    
    private func check(choice: String, choiceMax: Int) -> Int {
        if var choiceAsInt = Int(choice){
            // Check the number selected by player to choose a character in team
            while choiceAsInt < 1 || choiceAsInt > choiceMax{
                wrongNumber(numberMax: choiceMax)
                let newChoice = readLine()!
                if let newChoice = Int(newChoice){
                    choiceAsInt = newChoice
                }
            }
            return choiceAsInt
        }
        else{
            isNotNumber()
            let newChoice = readLine()!
            let choiceAsInt = check(choice: newChoice, choiceMax: choiceMax)
            return choiceAsInt
        }
    }
    
    private func wrongNumber(numberMax: Int) {
        Style.separatorForFlash()
        print("Vous devez choisir un chiffre entre 1 et \(numberMax)")
        Style.separatorForFlash()
    }
    
    private func isNotNumber() {
        Style.separatorForFlash()
        print("Vous devez saisir un chiffre !")
        Style.separatorForFlash()
    }
}
