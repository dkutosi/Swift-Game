//
//  SayCommand.swift
//  StarterGame
//
//  Created by Daniel on 4/6/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class SayCommand: Command {
    override init() {
        super.init()
        self.name = "say"
    }
    
    override func execute(player: Player) -> Bool {
        if hasSecondWord() {
            player.say(secondWord!)
        } else {
            player.warningMessage("\nSay What?")
        }
        return false
    }
}