//
//  PlayerBag.swift
//  StarterGame
//
//  Created by Daniel on 4/29/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class MyBag : Item {

    var maximumWeight : float_t
    var maximumVolume : float_t
    
    var container : [String : Item]
    
    override init(name: String, weight: float_t, value: float_t, volume: float_t) {
        self.container = [String : Item]()
        self.maximumVolume = 1000.0
        self.maximumWeight = 1000.0
        super.init(name: name, weight: weight, value: value, volume: volume)
    }
    
    override func isContainer() -> Bool{
        return true
    }
    //to store item inside the container
    func store(item : Item) -> Bool{
        if item.name == "Redbull" {
            self.increaseEnergy()
            return true
        }
        else if self.checkMax() == false {
            container[item.name] = item
            return true
        }
        return false
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
    
    func setMaxWeight(){
        self.maximumVolume = maximumWeight + 10
    }
    
    func setMaxVolume(){
        self.maximumWeight = maximumVolume + 10
    }
    
    func increaseEnergy(){
        self.setMaxWeight()
        self.setMaxVolume()
    }
    
    override func description() -> String{
        return "\(self.getName()) with weight \(self.getWeight() ) and value \(self.getValue()) and volume is \(self.getVolume())"
    }
    
    func isMaximumWeight() -> Bool{
        if self.getWeight() > self.maximumWeight {
            return true
        }
        else{
            return false
        }
    }
    
    func isMaximumVolume() -> Bool{
        if self.getVolume() > self.maximumVolume {
            return true
        }
        else{
            return false
        }
    }
    
    func checkMax() -> Bool {
        if self.isMaximumVolume() == true || self.isMaximumWeight() == true {
            return true
        }
        else{
            return false
        }
    }
    
    func getList() -> String {
        var listing : String = "\(name) contains\n"
        
        for item in container.values{
            listing += "\n * \(item.description())"
        }
        return listing
    }


}
