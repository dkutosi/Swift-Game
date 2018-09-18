//
//  Item.swift
//  StarterGame
//
//  Created by Daniel on 4/11/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
//class defines items
//cass uses decorator patten
//decorator adds to the functionality of an Item
//on the other hand, delegate is used to replace certain functionality of the item
class Item{
    var name : String
    var weight : float_t
    var value : float_t
    var decorator : Item? //<- decorator patten
    var volume : float_t
    
    convenience init(){
        self.init(name: "nameless")
    }
    
    convenience init(name: String){
        self.init(name: name, weight: 1)
    }
    
    convenience init(name: String, weight: float_t){
        self.init(name: name, weight: weight, value: 1.0)
    }
    convenience init(name: String, weight: float_t, value: float_t){
        self.init(name: name, weight: weight, value: value, volume: 2.0)
    }
    init(name: String, weight: float_t, value: float_t, volume : float_t){
        self.name = name
        self.weight = weight
        self.value = value
        self.volume = volume
    }
    
    func getValue() -> float_t{
        if decorator != nil{
           return value + (decorator?.getValue())!
        }
        return value
    }
    
    func getWeight() -> float_t {
        if decorator != nil {
            return weight + (decorator?.getWeight())!
        }
        return weight
    }
    func getVolume() -> float_t{
        if decorator != nil{
            return volume + (decorator?.getVolume())!
        }
        return volume
    }
    
    func getName() -> String{
        if decorator != nil {
            return "\(name) with \((decorator?.getName())!)"
        }
        else {
            return name
        }
    
    }
    
    func isPickable() -> Bool {
        if self.getWeight() > 50.0 {
            return false
        }
        else {
            return true
        }
    }
    
    //decorator is added at the end
    func addDecorator(decorator : Item?){
        if decorator != nil {
            self.decorator?.addDecorator(decorator)
        }
        else{
            self.decorator = decorator
        }
    }

    func removeDecorator(decorator : Item?)->Item?{
        return decorator?.removeDecorator(decorator)
    
    }
    
    //checks to see if the item is in a container
    func isContainer()-> Bool{
        return false
    }
    
    func description() -> String{
        return "\(self.getName()) with weight \(self.getWeight() ) and value \(self.getValue())"
    }
}