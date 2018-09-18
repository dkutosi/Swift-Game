//
//  Room.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/16/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//
//Class Room Work

import Foundation
import Cocoa


class Room {
    var exits : [String : Door]
    var tag : String
    var delegate : RoomProtocal?
    var item: Container? //<--place where to put item
    //var container : [String : Item]? //<--will hold items//composition method
    var character : Character2?
    var two : Bool
    
    convenience init() {
        self.init(tag: "No Tag")
    }
    
    init(tag : String) {
        exits = [String : Door]()
        self.tag = tag
        self.two = false
    }
    
    func say(message : String) -> String{
        
        if delegate != nil {
            return (delegate?.say(message))!
        }
        return message
    }
    
    // method returns the description of the item
    func describe() -> String{
        if item != nil{
            return (item?.description())!
        }
        else{
            return "There is no item here."
        }
    }
    
    //rungs the examine things from player io
    func examine() -> String{
        
        if item != nil{
            if ((item!.isContainer())){
                return (item! as Container!).getList()
            }
            else{
                return "Nothing to examine"
            }
        }
        else{
            return "There is no item here."
        }
    }
    
    func inRoom() -> Bool{
        return true
    }
    
    ///method modified to remove the room
    func setExit(exitName : String, door : Door?) {
        if door == nil {
            //exits[exitName] = nil
            exits.removeValueForKey(exitName)
        }
        else{
            exits[exitName] = door
        }
    }
    
    func getExit(exitName : String) -> Door? {
        return exits[exitName]
    }
    
    func getExits() -> String {
        let exitNames : [String] = [String](exits.keys)
        return "Exits: " + exitNames.joinWithSeparator(" ")
    }
    
    func getTheseExits() -> String {
        let exitNames : [String] = [String](exits.keys)
        return "Exits: " + exitNames.joinWithSeparator("")
    }
    
    func getAutoExists() -> [String] {
        let exitNames : [String] = [String](exits.keys)
        return exitNames
    }
    
    
    func setTwoPeople(){
        self.two = true
        
    }
    func twoPeople() -> Bool{
        return self.two
        
    }
    
     
    func description() -> String {
        return "You are \(tag).\n *** \(self.getExits())"
        //return "The count is \(self.getAutoExists().count)"
    }
    
    deinit {
        tag = ""
        exits.removeAll()
    }
}
