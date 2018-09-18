//
//  SellCommand.swift
//  StarterGame
//
//  Created by Prabhjot Sandhu on 4/27/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class SellCommand: Command {
    override init() {
        super.init()
        self.name = "sell"
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
