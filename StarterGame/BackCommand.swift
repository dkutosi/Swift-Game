//
//  BackCommand.swift
//  StarterGame
//
//  Created by Cameryn Holstick on 4/26/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class BackCommand: Command {
    override init() {
        super.init()
        self.name = "back"
    }
    
    override func execute(player: Player) -> Bool {
        if hasSecondWord() {
            player.warningMessage("\nSorry I don't understand\n")
            
        } else {
            player.goToPrevious()
        }
        return false
    }
}

