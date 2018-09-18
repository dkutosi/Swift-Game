//
//  Player.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/16/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class Character  {
    var currentRoom : Room
    var io : GameOutput
    var name : String
    var greeted : Bool
    var decorator : Item?

 
    init(room : Room, output : GameOutput, name : String) {
        currentRoom = room
        self.io = output
        self.name = name
        self.greeted = false
        
    
        
    }
    
    func getName() -> String{
        return name
    }
    
    func getDecorator() -> String{
        return decorator!.getName()
    }
    
    func walkTo(direction : String){
        let door : Door? = currentRoom.getExit(direction)
        if door != nil {
            if (door!.isOpen() == true) {
                let nextRoom : Room? = door?.getRoom(currentRoom)
                if nextRoom != nil {
                    

                    let lastRoom = self.currentRoom
                    self.currentRoom = nextRoom!//going to next room
                  
                    //this notification is sent to the controller and update relevant views.
                    //the player and the current room are passed on into the views.
                    NSNotificationCenter.defaultCenter().postNotificationName("CharacterDidEnterRoom", object: currentRoom)
             
                }
            }else {
             //   self.errorMessage("\nThe door '\(direction)' is closed.")
            }
        } else {
            //self.errorMessage("\nThere is no door on '\(direction)'")
        }
    }
    
    func doThis(){

        var image = StartGoing(room: self.currentRoom, player: self)
        image.goNow()
        
    }
    
    func printScreen(){
        io.sendLine("This works")
    }
    
    func outputMessage(message : String) {
        io.sendLine(message)
    }
    
    func outputMessage(message : String, color : NSColor) {
        let lastColor : NSColor = io.currentColor
        io.currentColor = color
        self.outputMessage(message)
        io.currentColor = lastColor
    }
    
    func errorMessage(message : String) {
        self.outputMessage(message, color: NSColor.redColor())
    }
    
    func warningMessage(message : String) {
        self.outputMessage(message, color: NSColor.orangeColor())
    }
    
    func commandMessage(message : String) {
        self.outputMessage(message, color: NSColor.brownColor())
    }
}
    
    
        
    
    

