//
//  Point.swift
//  StarterGame
//
//  Created by Prabhjot Sandhu on 4/27/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class Point{
    var value : float_t
    var visited : Bool
    var decorator : Point?
    var visitedRoom : [String]
    var currentPoints : float_t
    
    convenience init(){
        self.init(value : 0.0)
    }
    
    convenience init(value: float_t){
        self.init(value: value, visited: false)
    }
    
    init(value: float_t, visited: Bool){
        self.value = value
        self.visited = visited
        
        self.visitedRoom = [String]()
        self.currentPoints = 0.0
    }
    
    func getValue()->float_t{
        if decorator != nil{
            return value + (decorator?.getValue())!
        }else {
            return value
        }
    }
    func addRoom(string : String){
        if self.isVisited(string) == false && string != "lobby"{
            self.visitedRoom.append(string)
            self.currentPoints = self.currentPoints + 3
        }
    
    }
    func isVisited(string : String)->Bool{
        if visitedRoom.count > 0{
            visited = visitedRoom.contains(string)
        }
        return visited

    }
    func points() -> float_t{
        return self.currentPoints
        
    }
    
    func removePoints(value : float_t) {
        self.currentPoints = self.currentPoints - value
        
    }
    
    
}
    

