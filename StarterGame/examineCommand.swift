//
//  examineCommand.swift
//  StarterGame
//
//  Created by Daniel on 4/13/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
class ExamineCommand : Command{
    
    override init() {
        super.init()
        self.name = "examine"
    }
    
    override func execute(player: Player) -> Bool {
        if !hasSecondWord() {
            player.examine()
        }
        else {
            player.warningMessage("\nI cannot describe \(secondWord!)?")
        }
        return false
    }
}
