//
//  Game.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/17/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class Game {
    var player : Player?
    var police : Character?
    var parser : Parser
    var playing : Bool
    
    init(gameIO : GameOutput) {
        playing = false
        parser = Parser(newCommands: CommandWords())
        
        player = Player(room: GameWorld.sharedInstance.entrance, output: gameIO)
        //police = Character(room: GameWorld.sharedInstance.trigger)
    
      
    }
    
    func createWorld() -> Room {
        let room101 = Room(tag: "in room101")
        let lobby = Room(tag: "in lobby")
        let lobbyShop = Room(tag: "in shop")
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
            
        connectRooms(lobby, room2: room101, exitName1: "In the Lobby- main entrance.", exitName2: "in the room 101.")
        connectRooms(lobby, room2: room201, exitName1: "In the Lobby- main entrance.", exitName2: "in the room 201.")
        connectRooms(lobby, room2: room301, exitName1: "In the Lobby- main entrance.", exitName2: "in the room 301.")
            
        connectRooms(room101, room2: room102, exitName1: "in the room 101.", exitName2: "In the room 102.")
        connectRooms(room101, room2: room201, exitName1: "in the room 101.", exitName2: "In the room 201.")
            
        connectRooms(room102, room2: room103, exitName1: "in the room 102.", exitName2: "In the room 103.")
        connectRooms(room102, room2: room202, exitName1: "in the room 102.", exitName2: "In the room 202.")
            
        connectRooms(room103, room2: room104, exitName1: "in the room 103.", exitName2: "In the room 104.")
        connectRooms(room103, room2: room203, exitName1: "in the room 103.", exitName2: "In the room 203.")
            
        connectRooms(room104, room2: room204, exitName1: "in the room 104.", exitName2: "In the room 204.")
            
        connectRooms(room201, room2: room202, exitName1: "in the room 201.", exitName2: "In the room 202.")
        connectRooms(room201, room2: room301, exitName1: "in the room 201.", exitName2: "In the room 301.")
            
        connectRooms(room202, room2: room203, exitName1: "in the room 202.", exitName2: "In the room 203.")
        connectRooms(room202, room2: room302, exitName1: "in the room 202.", exitName2: "In the room 302.")
            
        connectRooms(room203, room2: room204, exitName1: "in the room 203.", exitName2: "In the room 204.")
        connectRooms(room203, room2: room303, exitName1: "in the room 303.", exitName2: "In the room 303.")
            
        connectRooms(room204, room2: room304, exitName1: "in the room 204.", exitName2: "In the room 304.")
            
        connectRooms(room301, room2: room302, exitName1: "in the room 301.", exitName2: "In the room 302.")
            
        connectRooms(room302, room2: room303, exitName1: "in the room 302.", exitName2: "In the room 303.")
            
        connectRooms(room303, room2: room304, exitName1: "in the room 303.", exitName2: "In the room 304.")
        return lobby
    }

    func start() {
        playing = true
        player?.outputMessage(welcome())
    }
    
    func end() {
        playing = false
        player?.outputMessage(goodbye())
        
    }
    
    func welcome() -> String {
        let message = "Welcome to the World of CSU!\n\nThe World of CSU is a new, incredibly boring adventure game.\n\nType 'help' if you need help."
        return "\(message)\n\n\(player!.currentRoom.description())"
        
    }
    
    func goodbye() -> String {
        return "\nThank you for playing, Goodbye.\n"
    }
    
    
    
    func execute(commandString : String) -> Bool {
        var finished : Bool = false
        if playing {
            player?.commandMessage("\n>\(commandString)")
            let command : Command? = parser.parseCommand(commandString)
            if command != nil {
                finished = (command?.execute(player!))!
            } else {
                player?.errorMessage("\nI don't understand...")
            }
        }
        return finished
    }
    
    @objc func endGame(notification : NSNotificationCenter){
        self.end()
        //execute("quit")<- creates a race condition and may not execute properly.
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
