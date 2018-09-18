//
//  GameProtocol.swift
//  StarterGame
//
//  Created by Prabhjot Sandhu on 4/20/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation


protocol RoomProtocal{
    func say(message : String) -> String
}


protocol Lockable{
    func lock()
    func unlock()
    func isLocked()->Bool
    func canClose()->Bool
}

protocol CharacterProtocal {
    func walkTo(direction : String)

}