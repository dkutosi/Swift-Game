//
//  Player.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/16/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//
//

//Create  new character class for character. the character class
//will have the walk to method
//create a post notification to send notification from character to wall
//create a post noticication from game to character.
//call a method is the two are in the same room---world should check.
//if true, character speaks first

import Foundation
import Cocoa

class Player : CharacterProtocal {
    var currentRoom : Room
    var io : GameOutput
    var history : [String]
    var last : String = "lobby"
    var item : Item?
    var points : Point
    var bag : MyBag
    var start : Bool = true
    var char : Character
    var char2 : Character

    
    
    init(room : Room, output : GameOutput) {
        currentRoom = room
        self.io = output
        history = [String]()
        history.append(last)
        points = Point()
        bag = MyBag(name: "bag", weight: 7.0, value: 2.0, volume: 3.0)
        char = Character(room: room, output: self.io, name: "tiger")
        char2 = Character(room: room, output: self.io, name: "tiger")
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(numberToCall(_: )), name: "PlayerDidEnterRoom", object: nil)
        
    }
    
     

    
    func walkTo(direction : String){
        let door : Door? = currentRoom.getExit(direction)
        if door != nil {
            if (door!.isOpen() == true) {
                let nextRoom : Room? = door?.getRoom(currentRoom)
                if nextRoom != nil {
                    
                    
                    self.history.append(direction)
                    self.points.addRoom(direction)
                    let lastRoom = self.currentRoom
                    self.currentRoom = nextRoom!//going to next room
                    //NSNotificationCenter.defaultCenter().postNotificationName("PlayerWillEnterRoom", object: currentRoom)
                    //Generating a singleton event to notify the system that you have moved to next room.
                    //this notification is sent to the controller and update relevant views.
                    //the player and the current room are passed on into the views.
                    NSNotificationCenter.defaultCenter().postNotificationName("PlayerDidEnterRoom", object: currentRoom)
                    self.outputMessage("\n\(nextRoom!.description())")//<--locations code here to prevent race condition
                    //NSNotificationCenter.defaultCenter().postNotificationName("PlayerDidLeaveRoom", object: lastRoom)
                    
            
                    self.char.doThis()
                        
                    hasTwo()
                    
                    
                }
        }else {
            self.errorMessage("\nThe door '\(direction)' is closed.")
        }
    } else {
        self.errorMessage("\nThere is no door on '\(direction)'")
    }
    }

    
    func addToHistory(string : String)
    {
        self.last = string
        self.history.append(self.last)
    }
    
    func goToPrevious()
    {
        if history.count > 1
        {
            history.removeLast()
            last = self.history.removeLast()
            
            self.walkTo(last)
        }
        else{
            self.errorMessage("\nYou are already in the lobby\n")
        }
        
        
    }
    func currentPoints(){
       self.outputMessage("Your current points are: \(self.points.points())")
    }
    
    
    
    //what the player will say
    func say(message : String){
        //io.sendLine("\nThe player said '\(message)'") //<- i.o used to send messages to console
        self.outputMessage("\nThe room responded \(currentRoom.say(message)) to my message)\n")
    }
    
    
    func describe(){
        //io.sendLine("\nI got your message!. Roger, Roger!\n")
        self.outputMessage("\n\(currentRoom.describe())\n")
        self.outputMessage("\nYou bag currently has the following items\n \(self.bag.description())\n")
        self.outputMessage("\nYou Currently are in room: \(self.currentRoom.description())\n")
        self.outputMessage("\n\(self.currentRoom.description())\n")
    }
    
    
    //created after command for the io
    func examine(){
        //io.sendLine("\nI got your message!. Roger, Roger!\n")
        self.outputMessage("\n\(currentRoom.examine())\n")
    }
    
    func hasTwo(){
        if currentRoom.twoPeople(){
        self.outputMessage("\nYou are not allone \n Please be polite and great hello to Jeremy")
        }
    }
    
    
    //to add item to the bad
    func addToBag(item : Item){
        self.bag.store(item)
    }

   
    
    func getItem()->String{
        let playerDecorator : String = (self.item?.name)!
        return playerDecorator
    }
    
    func pickup(theItem : String){
        if currentRoom.item != nil{
            if currentRoom.item?.container[theItem] == nil{
                self.errorMessage("\nItem not here\n")
                self.outputMessage("\n\(self.currentRoom.item!.getList())\n")
                }
            else {
                if currentRoom.item!.isPickable() {
                    self.item = currentRoom.item?.container[theItem]
                    currentRoom.item!.container.removeValueForKey(theItem)
                    self.outputMessage("\nYou picked up a \(theItem)\n")
                    self.outputMessage("\nYou are now carrying a \(theItem)!\n")
                } 
                else{
                    self.outputMessage("\nYou are not allowed to pick the \(theItem)\n")
                }
            }
        }
    }
    
    
    func buy(item : String){
        
        if self.bag.checkMax() == false {
            if currentRoom.tag == "in shop" {
                if currentRoom.item != nil{
                    if currentRoom.item?.container[item] == nil{
                        self.errorMessage("\nThere is no item in here.\n")
                        self.outputMessage("\n\(self.currentRoom.item!.getList())\n")
                }
                else{
                     
                        if self.points.points() > ((currentRoom.item?.container[item]?.getValue())! - 1){
                            
                            self.item = currentRoom.item?.container[item]
                            let myValue : float_t = (currentRoom.item?.container[item]?.getValue())!
                            self.points.removePoints(myValue)
                            let gotItem = currentRoom.item!.container.removeValueForKey(item)
                            self.addToBag(gotItem!)
                            self.outputMessage("\nYou bought \(item).\n")
                        //then put the item into a player's bag & print it
                    }
                    else{
                        self.errorMessage("\nSorry, you don't have enough points.\n")
                        }                
                    }
                    
                }
            }
            else {
                self.errorMessage("\nYou can only purchase from the shop.\n")
            }
        }
        else {
            self.errorMessage("\nYour band exceeds the weight or volume.\n")
            
        }
    }
    
    
    func open(exitName : String){
        let door : Door? = currentRoom.getExit(exitName)
        if door != nil{
            if door!.isOpen() == true {
                self.warningMessage("\nThe exit \(exitName) is already open.\n")
            }else {
                door!.open()
                if door!.isOpen(){
                    self.outputMessage("\nThe exit \(exitName) is now open.\n")
                }else {
                    if door!.isLocked() {
                        warningMessage("\nThe exit \(exitName) could not be opened because it is locked.\n")
                    }else{
                        warningMessage("\nThe exit \(exitName) could not be opened for an unknown reason.\n")
                    }
                }
            }
        }else{
            self.errorMessage("\nThere is no door on \(exitName)\n")
        }
        
    }
    
    //Player greating NPC
    func greetCharacter(greeting : String){
        self.outputMessage("\nYou greeted the stranger by saying: \(greeting).\n")
        //self.outputMessage("\nStranger: 'Whatever dude, I have a \(self.currentRoom.character!.getDecorator()), want it?\n")
        self.currentRoom.character?.greeted = true
    }
    
    
    
    func getCharacItem(item : String){
        self.outputMessage("\nAttempting to get \(item) from stranger..........\n")
        
        //Sets the item decorating the character to a new variable that will be used to
        //retrieve and store the character's item in the players bag.
        let itemFromCharac : Item = (self.currentRoom.character?.decorator)!
        
        //Checks to see if character was properly greeted before getting the character's item.
        //Also checks the weight and volume of the players bag to make sure the item will fit.
        if((self.currentRoom.character?.greeted) != false)
        {
            if self.bag.checkMax() == true {
                self.bag.store(itemFromCharac)
                self.outputMessage("\nRetrieved \(itemFromCharac.getName()) from the stranger!\n")
            }
            else{
                self.outputMessage("\nStranger: 'You got bag issues homie :-('\n")
            }
            
        }
        else
        {
            self.outputMessage("\nStranger: 'YOU THINK I'M GONNA GIVE YOU MY LAPTOP WITHOUT SO MUCH AS A GREETING!?!? GET OUT OF HERE NOW AND DON'T LOOK BACK OR THERE MAY BE DIRE CONSEQUENCES...\n")
        
        }
    
    }
    
 
    
    //To get room exits
    func getRoomExits(){
        self.outputMessage(self.currentRoom.getExits())
    }
    
    
    @objc func numberToCall(notification : NSNotification){
        // print("You got a notification named \(notification.name)")//let you know players entered room
        // print("You got a notification named \(notification.name)")
        
        let room : Room = notification.object as! Room
        //self.playerRoom = room
        print("Notification: Player saying I am in \(room.tag)") //<-to print notificaitons
        
        
        
    }
   
    
    func unlock(exitName : String){
        let door : Door? = currentRoom.getExit(exitName)
        if door != nil{
            door!.unlock()
        } else{
            self.errorMessage("The door is already unlock \(exitName)\n")
        }
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
