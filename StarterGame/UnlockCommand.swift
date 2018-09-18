//
//  UnlockCommand.swift
//  StarterGame
//
//  Created by Prabhjot Sandhu on 4/20/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class UnlockCommand: Command {
    override init() {
        super.init()
        self.name = "unlock"
    }
    
    override func execute(player: Player) -> Bool {
        if hasSecondWord() {
            player.unlock(secondWord!)
        } else {
            player.warningMessage("\nUnlock What?")
        }
        return false
    }
}
