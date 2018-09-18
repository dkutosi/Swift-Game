//
//  DescribeCommand.swift
//  StarterGame
//
//  Created by Daniel on 4/11/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation

class DescribeCommand : Command{

override init() {
    super.init()
    self.name = "describe"
}

    override func execute(player: Player) -> Bool {
        if !hasSecondWord() {
        player.describe()
        }
        else {
        player.warningMessage("\nI cannot describe \(secondWord!)?")
    }
    return false
}
}
