//
//  PickUpCommand.swift
//  StarterGame
//
//  Created by Prabhjot Sandhu on 4/27/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class PickUpCommand: Command {
    override init() {
        super.init()
        self.name = "pickup"
    }
    
    override func execute(player: Player) -> Bool {
        if hasSecondWord() {
            player.pickup(secondWord!)
        } else {
            player.warningMessage("\nI cannot pickup that.\n")
        }
        return false
    }
}