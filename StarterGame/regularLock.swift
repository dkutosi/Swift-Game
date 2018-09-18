//
//  regularLock.swift
//  StarterGame
//
//  Created by Prabhjot Sandhu on 4/20/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation

class regularLock : Lockable{
    var lockedState : Bool = false

    func lock(){
        lockedState = true
    }
    func unlock(){
        lockedState = false
    }
    func isLocked() -> Bool {
        return lockedState
    }
    
    func canClose() -> Bool {
        return true
    }


}