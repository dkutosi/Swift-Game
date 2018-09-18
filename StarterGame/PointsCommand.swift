//
//  PointsCommand.swift
//  StarterGame
//
//  Created by Prabhjot Sandhu on 4/28/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class PointsCommand: Command {
    override init() {
        super.init()
        self.name = "points"
    }
    
    override func execute(player: Player) -> Bool {
        if hasSecondWord() {
            player.warningMessage("\nSorry, I don't understand stand\n")
        } else {
             player.currentPoints()
        }
        return false
    }
}
