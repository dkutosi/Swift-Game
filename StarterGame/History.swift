//
//  History.swift
//  StarterGame
//
//  Created by Cameryn Holstick on 4/26/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class History
{
    var history : [String]
    
    init()
    {
        history = [String]()
    }
    
    func addRooms(room : String)
    {
        history.append(room)
    }
    
    func removeRoom() ->String
    {
        //history.removeLast()
        return history.removeLast()
    }
    
    func count() -> Int
    {
        return history.count
    }
}
