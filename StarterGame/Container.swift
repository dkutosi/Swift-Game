//
//  Container.swift
//  StarterGame
//
//  Created by Daniel on 4/13/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
///class will get allt he things from the world that are added, the items and make it work.
//this is to create objects that contain other things
//Use this to put items into a room and to place items with the characters

class Container : Item{
    
    

    var container : [String : Item]

    override init(name: String, weight: float_t, value: float_t, volume: float_t) {
        container = [String : Item]()
        super.init(name: name, weight: weight, value: value, volume: volume)
    }
    
    override func isContainer() -> Bool{
        return true
    }
    //to store item inside the container
    func store(item : Item){
        container[item.name] = item
    }
    ///returns the container
    func retrieve(itemName : String) -> Item?{
        return container.removeValueForKey(itemName)
    }
    
    override func getValue() -> float_t{
        var totalValue : float_t = 0
        
        for item in container.values{
            totalValue += item.getValue()
        }
        totalValue += super.getValue()
        return totalValue
    }
    
    override func getWeight() -> float_t {
        var totalWeight : float_t = 0
        
        for item in container.values{
            totalWeight += item.getWeight()
        }
        totalWeight += super.getWeight()
        return totalWeight
    }
    override func getVolume() -> float_t {
        var totalVolume : float_t = 0
        
        for item in container.values{
            totalVolume += item.getVolume()
        }
        totalVolume += super.getVolume()
        return totalVolume
    }
    
    func getList() -> String {
        var listing : String = "\(name) contains\n"
        
        for item in container.values{
            listing += "\n * \(item.description())"
        }
        return listing
    }
}
