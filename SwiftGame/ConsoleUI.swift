//
//  ConsoleUI.swift
//  SwiftGame
//
//  Created by Mickael on 11/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

class ConsoleUI: UI {
    
    func introduction() {
      
        print("Bienvenue dans SwiftGame ! Un jeu dans lequel deux équipes vont s'affronter dans un combat à mort. Entrez dans l'arene...\n")
        print("Chaque joueur devra constituer une équipe avec 3 personnages...\n")
        print("Voici les personnages existants, et que vous pourrez choisir avec leur numéro :\n")
    }
    
    func startCreateTeams() {
        
        print("Chaque personnage a des caractéristiques différentes...\n")
        print("Vous voulez en savoir plus ? Commencons par constituer les équipes !\n")
        print("Souhaitez vous que les équipes soit créées automatiquement ou préférez vous le faire vous même ?\n\n1. Tapez 1 pour le mode Auto\n\n2. Tapez 2 pour le mode manuel\n")
    }
    
    func playerName(number: Int) {
        
        print("\nJoueur \(number+1), quel est votre Nom ?")
    }
    
    func playerNameEmpty() {
        
        Style.separatorForFlash()
        print("\nVous devez entrer un nom. Saisissez à nouveau...\n")
        Style.separatorForFlash()
    }
    
    func playersReady() {
        
        Style.separatorForFlash()
        print("Les joueurs et leurs équipes sont prêts. Passons au combat !")
        Style.separatorForFlash()
    }
    
    func teamState(to player: Player){
        
        print("\n*** Etat des troupes de l'équipe de \(player.name) ***\n")
    }
    
    func teamPlayerIsDead(from player: Player){
        
        print("-- Le joueur \(player.name) n'a plus de personnages. Ils sont tous morts !")
    }
    
    func startFight() {
        
        Style.separatorForFlash()
        print("Il est temps de rentrer dans l'ârene !")
        Style.separatorForFlash()
    }
    
    func selectCharacter(from player: Player) {
        
        print("A toi de jouer \(player.name) !\n")
        print("Choisis un personnage de ton équipe :\n")
    }
    
    func selectOpponentCharacter() {
        
        print("Choisis une cible dans l'équipe adverse...\nOu un personnage de ton équipe si tu viens de sélectionner un Mage :\n")
    }
    
    func gameIsOver(winner: String, rounds: Int) {
        
        Style.separatorForFlash()
        print("Partie finie ! Bravo \(winner), vous avez gagné. Nombre de tours effectués : \(rounds)")
        Style.separatorForFlash()
    }
    
    func wrongNumber(numberMax: Int) {
        
        Style.separatorForFlash()
        print("Vous devez choisir un chiffre entre 1 et \(numberMax)")
        Style.separatorForFlash()
    }
    
    func isNotNumber() {
        
        Style.separatorForFlash()
        print("Vous devez saisir un chiffre !")
        Style.separatorForFlash()
    }
    
    func carePowerIncrease(care: Int) {
        
        Style.separatorForFlash()
        print("Le Mage a gagné de l'expérience ! Il peut soigner jusqu'à \(care) \n")
        Style.separatorForFlash()
    }
    
    func newWeapon(strength: Int) {
        
        Style.separatorForFlash()
        print("Tu as une nouvelle arme pour ce tour ! Qui te donne une force de \(strength)")
        Style.separatorForFlash()
    }
    
    func characterName() {
        
         print("\nQuel sera son nom ?")
    }
    
    func characterNameEmpty() {
        
        Style.separatorForFlash()
        print("Vous devez donner un nom à votre personnage ! Entrez un nom :")
        Style.separatorForFlash()
    }
    
    func characterNameExists() {
        
        Style.separatorForFlash()
        print("Ce nom existe déjà dans la partie. Choisissez un autre nom :")
        Style.separatorForFlash()
    }
    
    func characterCreated(character: Character) {
        
        print("\n\(character.name), \(character.type), a bien été ajouté à votre équipe.")
    }
    
    func teamCreated(name: String) {
        
        Style.separatorForFlash()
        print("\(name), votre équipe est constituée !")
        Style.separatorForFlash()
    }
}
