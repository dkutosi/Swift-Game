//
//  GameWorld.swift
//  StarterGame
//
//  Created by Daniel on 3/28/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa


class GameWorld {
    
    var entrance : Room
    var exit : Room
    var trigger : Room // another room created to recieve notifiactions demo
    var fromRoom : Room
    var toRoom : Room
    var toAlternate : Room
    static var sharedInstance : GameWorld = GameWorld()
    static var savedTag : String = ""
    
    private init(){ //makes the init private and cannot create a second instance of object
        //creates entrace to the world
        entrance = Room()
        exit = Room()
        trigger = exit
        fromRoom = exit
        toRoom = fromRoom
        toAlternate = toRoom
        
        
        let rooms = self.createWorld()
        entrance = rooms["entrance"]! //sets the entrance to string entrance
        exit = rooms["exit"]! //sets the exit string to exit
        trigger = rooms["trigger"]!
        fromRoom = rooms["fromRoom"]!
        toRoom = rooms["toRooms"]!
        let altRooms = self.createAltWorld()
        toAlternate = altRooms["entrance"]
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(numberToCall(_: )), name: "PlayerDidEnterRoom", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(playerWillEnterRoom(_: )), name: "playerWillEnterRoom", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(playerDidLeaveRoom(_: )), name: "playerDidLeaveRoom", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(openTheAlternateWorld(_: )), name: "playerOpenedFringe", object: nil)
    }
    
    func createWorld() -> [String : Room] {
        let outside = Room(tag: "outside the main entrance of the university")
        let cctParking = Room(tag: "in the parking lot at CCT")
        let boulevard = Room(tag: "on the boulevard")
        let universityParking = Room(tag: "in the parking lot at University Hall")
        let parkingDeck = Room(tag: "in the parking deck")
        let cct = Room(tag: "in the CCT building")
        let theGreen = Room(tag: "in the green in front of Schuster Center")
        let universityHall = Room(tag: "in University Hall")
        let schuster = Room(tag: "in the Schuster Center")
        let davidson = Room(tag: "in the Davidson Center")
        
        outside.setExit("boulevard", room: boulevard)
        
        boulevard.setExit("outside", room: outside)
        boulevard.setExit("cctParking", room: cctParking)
        boulevard.setExit("theGreen", room: theGreen)
        boulevard.setExit("universityParking", room: universityParking)
        
        cctParking.setExit("cct", room: cct)
        cctParking.setExit("boulevard", room: boulevard)
        
        cct.setExit("cctParking", room: cctParking)
        cct.setExit("schuster", room: schuster)
        
        schuster.setExit("cct", room: cct)
        schuster.setExit("universityHall", room: universityHall)
        schuster.setExit("theGreen", room: theGreen)
        
        theGreen.setExit("schuster", room: schuster)
        theGreen.setExit("boulevard", room: boulevard)
        
        universityHall.setExit("schuster", room: schuster)
        universityHall.setExit("universityParking", room: universityParking)
        
        universityParking.setExit("schuster", room: schuster)
        universityParking.setExit("universityHall", room: universityHall)
        universityParking.setExit("parkingDeck", room: parkingDeck)
        
        parkingDeck.setExit("universityParking", room: universityParking)
        
        var output : [String : Room] = [String : Room]()// returns the string and room
        output ["entrance"] = outside
        output ["exit"] = cct
        output["trigger"] = parkingDeck
        output["toRoom"] = davidson
        output ["fromRoom"] = schuster
        
        
        //returns a response with all caps
        universityHall.delegate = Yeller()
        //
        parkingDeck.delegate = Echo()
        davidson.delegate = WorldOpener()
        
        return output
        
        //second world created
        func createAltWorld() -> [String : Room] {
            let outside = Room(tag: "outside the main entrance of the university")
            let cctParking = Room(tag: "in the parking lot at CCT")
            let boulevard = Room(tag: "on the boulevard")
            let universityParking = Room(tag: "in the parking lot at University Hall")
            let parkingDeck = Room(tag: "in the parking deck")
            let cct = Room(tag: "in the CCT building")
            let theGreen = Room(tag: "in the green in front of Schuster Center")
            let universityHall = Room(tag: "in University Hall")
            let schuster = Room(tag: "in the Schuster Center")
            let davidson = Room(tag: "in the Davidson Center")
            
            outside.setExit("west", room: boulevard)
            
            boulevard.setExit("east", room: outside)
            boulevard.setExit("south", room: cctParking)
            boulevard.setExit("west", room: theGreen)
            boulevard.setExit("north", room: universityParking)
            
            cctParking.setExit("west", room: cct)
            cctParking.setExit("north", room: boulevard)
            
            cct.setExit("east", room: cctParking)
            cct.setExit("north", room: schuster)
            
            schuster.setExit("south", room: cct)
            schuster.setExit("north", room: universityHall)
            schuster.setExit("east", room: theGreen)
            
            theGreen.setExit("west", room: schuster)
            theGreen.setExit("east", room: boulevard)
            
            universityHall.setExit("south", room: schuster)
            universityHall.setExit("east", room: universityParking)
            
            universityParking.setExit("south", room: schuster)
            universityParking.setExit("west", room: universityHall)
            universityParking.setExit("north", room: parkingDeck)
            
            parkingDeck.setExit("south", room: universityParking)
            
            var output : [String : Room] = [String : Room]()// returns the string and room
            output ["entrance"] = outside
            output ["exit"] = cct
            output["trigger"] = parkingDeck
            output["toRoom"] = davidson
            output ["fromRoom"] = schuster
            
            //returns a response with all caps
            universityHall.delegate = Yeller()
            //
            parkingDeck.delegate = Echo()
            
            return output
            


    
    //This method will be called whenever a player enters the rooom. 
    //This function is an obejctive c funciton and reacheable through objective C
    //must pass an NS notification
    @objc func numberToCall(notification : NSNotification){
       // print("You got a notification named \(notification.name)")//let you know players entered room
       // print("You got a notification named \(notification.name)")
        
        let room : Room = notification.object as! Room
        //print("Notification: player is \(room.tag)") //<-to print notificaitons
        
        if room === exit {
            print("i got the exit")
            NSNotificationCenter.defaultCenter().postNotificationName("EndTheGame", object: nil)
        }
        
        if room === trigger {
            room.tag = GameWorld.savedTag
        }
        
    }
        //
        @objc func playerWillEnterRoom(notification : NSNotification){
            let room : Room = notification.object as! Room
            if room === trigger {
                //print ("BAAAAAAAM") <- used as demo...appeared before the entering of room
                //can be used to
                GameWorld.savedTag = room.tag
                room.tag = room.tag + "BAAAM!"//will hit BAAAM when reaches this point.
                fromRoom.setExit("secret", room: toRoom)
                toRoom.setExit("secret", room: fromRoom)
            }
        }
        
        @objc func playerDidLeaveRoom(notification : NSNotification){
            let room : Room = notification.object as! Room
            if room === toRoom {
                fromRoom.setExit("secret", room: nil)
            }
        }
            
            @objc funct openTheAlternateWorld(notification : NSNotification){
                entrance.setExit("alternate", room: toAlternate)
            }
    
    //removes calls that no longer exists.
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self) //removes you all notifications.
        //another removeObserver can be used to remove from speccific notifications.
    }
    
}
