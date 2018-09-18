//
//  Parser.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/17/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class Parser {
    var commands : CommandWords
    
    init(newCommands : CommandWords) {
        commands = newCommands
    }
    
    func parseCommand(commandString : String) -> Command? {
        
        var command : Command? = commands.get("")
        let words = commandString.componentsSeparatedByString(" ")//<- the seprator will make the empty string thing its a real string
        if words.count > 0 {
            command = commands.get(words[0])
            if command != nil {
                if words.count == 2 {
                    if words[1] != ""{ //<-prevent printing empty space
                        command?.secondWord = words[1]
                    }
                    else{
                        command?.secondWord = nil
                    }
                }
                else if words.count == 3 {
                    if words[2] != ""{ //<-prevent printing empty space
                         command?.secondWord = words[1]
                        command?.thirdWord = words[2]
                    }
                } else {
                    command?.secondWord = nil
                }
            }
        }
        
        return command
    }
    
    func description() -> String {
        return commands.description()
    }
}
