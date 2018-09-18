//
//  RoomDelegates.swift
//  StarterGame
//
//  Created by Daniel on 4/6/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

//class holding other classes...allowed in swift

class Yeller : RoomProtocal{
    func say(message : String) -> String {
        return message.uppercaseString
    }
}

class Echo : RoomProtocal{
    func say(message : String) -> String {
        return message + " " + message + " " + message + " " + message + " " + message
    }
}



class WorldOpener : RoomProtocal {
    func say(message: String) -> String {
       // if message.compare("Fringe") == 0 {
        if message == "Fringe"{
            NSNotificationCenter.defaultCenter().postNotificationName("PlayerOpenedFringe", object: nil)
            return "We opened a can of worms"
        }
        else{
            return message
        }
    }
}