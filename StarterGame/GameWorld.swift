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
    //var char : Character
    var playerRoom : Room
    var charRoom : Room
    var sameRoom : String
    
    
    private init(){ //makes the init private and cannot create a second instance of object
        //creates entrace to the world
        self.entrance = Room()
        exit = Room()
        trigger = exit
        fromRoom = exit
        toRoom = fromRoom
        toAlternate = toRoom
        //self.char = Character(room: self.entrance)
        playerRoom = self.entrance
        charRoom = self.entrance
        sameRoom = ""
        
        let rooms = self.createWorld()
        entrance = rooms["entrance"]! //sets the entrance to string entrance
        exit = rooms["exit"]! //sets the exit string to exit
        trigger = rooms["trigger"]!
        fromRoom = rooms["fromRoom"]!
        toRoom = rooms["toRoom"]!
        //let altRooms = self.createAltWorld()
        //toAlternate = altRooms["entrance"]!
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(numberToCall(_: )), name: "PlayerDidEnterRoom", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(characterToCall(_: )), name: "CharacterDidEnterRoom", object: nil)
       /*
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(playerWillEnterRoom(_: )), name: "playerWillEnterRoom", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(playerDidLeaveRoom(_: )), name: "playerDidLeaveRoom", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(openTheAlternateWorld(_: )), name: "playerOpenedFringe", object: nil) */
    }
    
    func createWorld() -> [String : Room] {
        let room101 = Room(tag: "in room101")
        let lobby = Room(tag: "in lobby")
        let lobbyShop = Room(tag: "in shop")
        //let room101 = Room(tag: "in the room101.")
        let room102 = Room(tag: "in room102")
        let room103 = Room(tag: "in room103")
        let room104 = Room(tag: "in room104")
        
        let room201 = Room(tag: "in room201")
        let room202 = Room(tag: "in room202")
        let room203 = Room(tag: "in room203")
        let room204 = Room(tag: "in room204")
        
        let room301 = Room(tag: "in room301")
        let room302 = Room(tag: "in room302")
        let room303 = Room(tag: "in room303")
        let room304 = Room(tag: "in room304")
        
        connectRooms(lobby, room2: room101, exitName1: "lobby", exitName2: "room101")
        connectRooms(lobby, room2: room201, exitName1: "lobby", exitName2: "room201")
        connectRooms(lobby, room2: room301, exitName1: "lobby", exitName2: "room301")
        connectRooms(lobby, room2: lobbyShop, exitName1: "lobby", exitName2: "shop")
        
        connectRooms(room101, room2: room102, exitName1: "room101", exitName2: "room102")
        connectRooms(room101, room2: room201, exitName1: "room101", exitName2: "room201")
        
        connectRooms(room102, room2: room103, exitName1: "room102", exitName2: "room103")
        connectRooms(room102, room2: room202, exitName1: "room102", exitName2: "room202")
        
        connectRooms(room103, room2: room104, exitName1: "room103", exitName2: "room104")
        connectRooms(room103, room2: room203, exitName1: "room103", exitName2: "room203")
        
        connectRooms(room104, room2: room204, exitName1: "room104", exitName2: "room204")
    
        connectRooms(room201, room2: room202, exitName1: "room201", exitName2: "room202")
        connectRooms(room201, room2: room301, exitName1: "room201", exitName2: "room301")
        
        connectRooms(room202, room2: room203, exitName1: "room202", exitName2: "room203")
        connectRooms(room202, room2: room302, exitName1: "room202", exitName2: "room302")
        
        connectRooms(room203, room2: room204, exitName1: "room203", exitName2: "room204")
        connectRooms(room203, room2: room303, exitName1: "room203", exitName2: "room303")
        
        connectRooms(room204, room2: room304, exitName1: "room204", exitName2: "room304")
        
        connectRooms(room301, room2: room302, exitName1: "room301", exitName2: "room302")
        
        connectRooms(room302, room2: room303, exitName1: "room302", exitName2: "room303")
        
        connectRooms(room303, room2: room304, exitName1: "room303", exitName2: "room304")
        
        

    
        
        var output : [String : Room] = [String : Room]()// returns the string and room
        output ["entrance"] = lobby
        output ["exit"] = room304
        output["trigger"] = room203
        output["toRoom"] = room201
        output ["fromRoom"] = room204
        
        
        //returns a response with all caps
        room104.delegate = Yeller()
        //
        lobby.delegate = Echo()
        room103.delegate = WorldOpener()
        

        lobby.item = Container(name: "Chest", weight: 2.0, value: 1.0)
        let stuff = Item(name: "Ruby", weight: 1.1, value : 15)
        lobby.item!.store(stuff)
        
        let crystal : Item = Item(name: "Ruby", weight: 1.1, value : 15)
        lobby.item?.decorator = crystal
        
        let shovel : Item = Item (name: "Shovel", weight : 1.0, value: 0.5)
        lobby.item!.store(shovel)
        
        lobbyShop.item = Container(name: "Shop", weight: 100.0, value: 1000.0)
        let pen = Item(name: "Pen", weight: 2.0, value: 3.0, volume: 3.0)
        lobbyShop.item!.store(pen)
        let pencil = Item(name: "Pencil", weight: 2.0, value: 2.0, volume: 3.0)
        lobbyShop.item!.store(pencil)
        let paper = Item(name: "Paper", weight: 1.0, value: 15.0, volume: 10.0)
        lobbyShop.item!.store(paper)
        let book = Item(name: "Book", weight: 16.0, value: 50.0, volume: 20.0)
        lobbyShop.item!.store(book)
        let notes = Item(name: "Notes", weight: 8.0, value: 50.0, volume: 15.0)
        lobbyShop.item!.store(notes)
        let scantron = Item(name: "Scantron", weight: 1.0, value: 80.0, volume: 8.0)
        lobbyShop.item!.store(scantron)
        let eraser = Item(name: "Eraser", weight: 1.0, value: 2.0, volume: 2.0)
        lobbyShop.item!.store(eraser)
        let calculator = Item(name: "Calculator", weight: 16.0, value: 150.0, volume: 12.0)
        lobbyShop.item!.store(calculator)
        let labGlasses = Item(name: "LabGlasses", weight: 5.0, value: 90.0, volume: 7.0)
        lobbyShop.item!.store(labGlasses)
        let labGloves = Item(name: "LabGloves", weight: 3.0, value: 10.0, volume: 4.0)
        lobbyShop.item!.store(labGloves)
        let laptop = Item(name: "Laptop", weight: 25.0, value: 800.0, volume: 500.0)
        lobbyShop.item!.store(laptop)
        
        
        let room104notes = Item(name: "Notes", weight: 8.0, value: 00.0, volume: 15.0)
        lobbyShop.item!.store(room104notes)
        let room104Scantron = Item(name: "Scantron", weight: 1.0, value: 00.0, volume: 8.0)
        lobbyShop.item!.store(room104Scantron)
        let room104Eraser = Item(name: "Eraser", weight: 1.0, value: 0.0, volume: 2.0)
        lobbyShop.item!.store(room104Eraser)
        let room104Calculator = Item(name: "room104Calculator", weight: 16.0, value: 0.0, volume: 12.0)
        lobbyShop.item!.store(room104Calculator)
        
        
        room101.item = Container(name: "Table", weight: 10.0, value: 1.0)
        let stuff2 = Item(name: "books", weight: 1.1, value : 15)
        room101.item?.store(stuff2)
        
        room103.item = Container(name: "Chair", weight: 10.0, value: 1.0)
        let stuff3 = Item(name: "books", weight: 1.1, value : 15)
        room103.item?.store(stuff3)
        
        room204.item = Container(name: "Pen", weight: 10.0, value: 1.0)
        let stuff4 = Item(name: "books", weight: 1.1, value : 15)
        room204.item?.store(stuff4)
        
        room302.item = Container(name: "Piano", weight: 10.0, value: 1.0)
        let stuff5 = Item(name: "books", weight: 1.1, value : 15)
        room302.item?.store(stuff5)
        
        room303.item = Container(name: "Empty Box", weight: 10.0, value: 1.0)
        let stuff6 = Item(name: "books", weight: 1.1, value : 15)
        room303.item?.store(stuff6)
        
        room203.item = Container(name: "Redbull", weight: 10.0, value: 1.0)
        let stuff7 = Item(name: "books", weight: 1.1, value : 15)
        room101.item?.store(stuff7)
        
        room304.item = Container(name: "Redbull", weight: 10.0, value: 1.0)
        let stuff8 = Item(name: "books", weight: 1.1, value : 15)
        room101.item?.store(stuff8)
        
        room104.item = Container(name: "Redbull", weight: 10.0, value: 1.0)
        let stuff9 = Item(name: "books", weight: 1.1, value : 15)
        room101.item?.store(stuff9)
        
        room202.item = Container(name: "Weed", weight: 1000.0, value: 1.0)
        let stuff10 = Item(name: "books", weight: 1.1, value : 15)
        room101.item?.store(stuff10)
        
        room203.item = Container(name: "Table", weight: 10.0, value: 1.0)
        let stuff11 = Item(name: "books", weight: 1.1, value : 15)
        room101.item?.store(stuff11)
        
        return output
        
    }
    
    func sendMessage(){
        if sameRoom == "true" {
            playerRoom.two = true
        }
        else{
            playerRoom.two = false
        }
    }
    
    //This method will be called whenever a player enters the rooom.
    //This function is an obejctive c funciton and reacheable through objective C
    //must pass an NS notification
    @objc func numberToCall(notification : NSNotification){
        // print("You got a notification named \(notification.name)")//let you know players entered room
        // print("You got a notification named \(notification.name)")
        
        let room : Room = notification.object as! Room
        self.playerRoom = room
        print("Notification: Player \(room.tag)") //<-to print notificaitons
        
        
        if room === trigger {
            room.tag = GameWorld.savedTag
        }
        
    }
    
    @objc func characterToCall(notification : NSNotification){
        
        let room : Room = notification.object as! Room
        self.charRoom = room
        let checker : RoomChecker = RoomChecker(playerRoom: self.playerRoom, charRoom: self.charRoom)
        let same : String = checker.toString()
        print("Notification: Same Room? \(same)")
        print("Notification: Character \(room.tag)\n") //<-to print notificaitons
        sameRoom = same
        sendMessage()
        
        
    }
    
//    func sameRoom(){
//        
//            NSNotificationCenter.defaultCenter().postNotificationName("PlayerDidEnterRoom", object: nil)
//            print("Notification: The other player is here")//<--locations code
//            
//             
//        
//    }
}