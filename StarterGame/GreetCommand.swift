//
//  GreetCommand.swift
//  StarterGame
//
//  Created by Daniel on 5/3/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class GreetCommand: Command
{
    override init()
    {
        super.init()
        self.name = "greet"
    }
    
    override func execute(player: Player) -> Bool
    {
        if hasSecondWord()
        {
            
            player.greetCharacter(thirdWord!)
            
            
        }
        else
        {
            player.warningMessage("\nGreet Who?\n")
        }
        return false
    }
    
}
