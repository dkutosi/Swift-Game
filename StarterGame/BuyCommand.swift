//
//  BuyCommand.swift
//  StarterGame
//
//  Created by Prabhjot Sandhu on 4/27/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class BuyCommand: Command {
    override init() {
        super.init()
        self.name = "buy"
    }
    
    override func execute(player: Player) -> Bool {
       if hasSecondWord(){
            player.buy(secondWord!)
            //player.addtoBag(secondWord!)
        } else {
            player.warningMessage("\nBuy What?")
        }
        return false
    }
}
