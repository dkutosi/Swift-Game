//
//  HelpCommand.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/17/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class HelpCommand: Command {
    var words : CommandWords
    
    init(commands : CommandWords) {
        words = commands
        super.init()
        self.name = "help"
    }
    
    override func execute(player: Player) -> Bool {
        if hasSecondWord() {
            player.warningMessage("\nI cannot help you with '\(secondWord!)'")
        } else {
            player.outputMessage("\nYou are lost. You are alone. You wander around the university.\n\nYour available commands are:\n\(words.description())")
        }
        return false
    }
}
