//
//  StartGoing.swift
//  StarterGame
//
//  Created by Daniel on 5/2/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class StartGoing{
    
    
    var door = String()
    var room : Room
    var player : Character
    var exists = [String]()
    var size : Int = 0
    var sizeArray : UInt32 = 0
    
   
    init(room : Room, player : Character){
        self.room  = room
        self.player = player
    }
    
    func getDoor() -> [String]{
        exists = room.getAutoExists()
        return exists
    }
    
    func description() -> String {
        sleep(2)
        return "The size of array is  has door: \(self.getDoor()[rand()])"
    }
    
    func rand() -> Int {
        
        
        if self.getDoor().count == 1 {
            sizeArray = 1
        }
            
        else if self.getDoor().count == 2 {
            sizeArray = 2
        }
            
        else if self.getDoor().count == 3 {
            sizeArray = 3
        }
        
        else{
            sizeArray = 4
        }
        
        let num = Int(arc4random_uniform(sizeArray))
        self.size = num as Int
        return size
    }
    
    func goNow(){
            //player.walkTo(self.getDoor()[rand()])
            player.walkTo(self.getDoor()[1]) //<----debuging purposes
        
        
    }
    

}