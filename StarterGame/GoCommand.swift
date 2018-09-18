//
//  GoCommand.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/17/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class GoCommand: Command {
    override init() {
        super.init()
        self.name = "go"
    }
    
    override func execute(player: Player) -> Bool {
        if hasSecondWord() {
            player.walkTo(secondWord!)
        
        } else {
            player.warningMessage("\nGo Where?")
        }
        return false
    }
}
