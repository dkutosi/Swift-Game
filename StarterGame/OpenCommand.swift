//
//  OpenCommand.swift
//  StarterGame
//
//  Created by Prabhjot Sandhu on 4/20/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class OpenCommand: Command {
    override init() {
        super.init()
        self.name = "open"
    }
    
    override func execute(player: Player) -> Bool {
        if hasSecondWord() {
            player.open(secondWord!)
        } else {
            player.warningMessage("\nOpen What?")
        }
        return false
    }
}
