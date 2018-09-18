//
//  Character2.swift
//  StarterGame
//
//  Created by Daniel on 5/3/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class Character2{
    
    var name : String
    var location : Room
    var decorator : Item?
    var greeted : Bool
    
    init(name : String, location : Room){
        self.name = name
        self.location = location
        self.greeted = false
        
    }
    
    func getName() -> String{
        return name
    }
    
    func getDecorator() -> String {
        return (decorator!.getName())
    }
    
    func setLocation(room : Room){}


}