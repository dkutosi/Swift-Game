
//
//  Door.swift
//  StarterGame
//
//  Created by Prabhjot Sandhu on 4/18/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class Door{
    var room1 : Room
    var room2 : Room
    private var closed : Bool
    var doorLock: Lockable?
    
    init(room1 : Room, room2 : Room){
        self.room1 = room1
        self.room2 = room2
        self.closed = false
    }
  
    func getRoom(fromRoom : Room)->Room{
        /*if fromRoom === room1 {
            return room2
        } else {
            return room1
        }*/
        return fromRoom === room1 ? room2 : room1
    }
    
    func lock(){
        if doorLock != nil{
            doorLock?.lock()
        }
    }
    func unlock(){
        if doorLock != nil{
            doorLock?.unlock()
        }
    }
    func isLocked()->Bool{
        if doorLock != nil{
            return (doorLock?.isLocked())!
        } else {
            return false
        }
    }
    func canClose()-> Bool{
        if doorLock != nil {
            return (doorLock?.canClose())!
        }else{
            return true
        }
    }
    func open(){
        if self.isLocked() {
            closed  = false
        }
        
    }
    func close(){
        if self.canClose(){
            closed = true
        }
    }
    func isOpen()-> Bool{
        return !closed
    }

}

//Static variable - connects different rooms
func connectRooms(room1 : Room, room2 : Room, exitName1 : String, exitName2 : String)-> Door{
    let door : Door = Door(room1: room1, room2: room2)
    room1.setExit(exitName2, door: door)
    room2.setExit(exitName1, door: door)
    return door
}
