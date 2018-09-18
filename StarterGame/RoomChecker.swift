//
//  RoomChecker.swift
//  StarterGame
//
//  Created by Daniel on 5/2/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class RoomChecker{
    
    var playerRoom : Room
    var charRoom : Room
    
    
    init(playerRoom: Room, charRoom: Room){
        self.playerRoom = playerRoom
        self.charRoom = charRoom
    }
    
    func isPresent() -> Bool {
        return playerRoom === charRoom
    }
    
    func toString() -> String {
        if self.isPresent() == true {
            return "true"
        }
        return "false"
    }
}