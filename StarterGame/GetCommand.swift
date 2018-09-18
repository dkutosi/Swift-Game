//
//  GetCommand.swift
//  StarterGame
//
//  Created by Daniel on 5/3/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

import Foundation
import Cocoa

class GetCommand: Command {
    override init() {
        super.init()
        self.name = "get"
    }
    
    override func execute(player: Player) -> Bool {
        if hasSecondWord() {
            
          //  player.getCharacItem(secondWord!)
            
        }
        else
        {
            player.warningMessage("\nGet What?")
        }
        return false
    }
}
