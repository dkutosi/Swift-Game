//
//  GameOutput.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/16/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class GameOutput {
    var output : NSTextView
    var currentColor : NSColor
    
    init(newOutput : NSTextView) {
        output = newOutput
        currentColor = NSColor.blueColor()
    }
    
    func sendLine(line : String) {
        let start = output.string?.lengthOfBytesUsingEncoding((output.string?.smallestEncoding)!)
        output.textStorage?.appendAttributedString(NSAttributedString(string: line))
        let end = output.string?.lengthOfBytesUsingEncoding((output.string?.smallestEncoding)!)
        output.setTextColor(currentColor, range: NSMakeRange(start!, end! - start!))
        output.scrollRangeToVisible(NSMakeRange(end!, 0))
    }
    
    func clear() {
        output.string = ""
        output.setTextColor(currentColor, range:  NSMakeRange(0, 0))
    }
}
