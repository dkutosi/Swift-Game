//
//  AppDelegate.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/15/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var Output: NSScrollView!
    
    @IBOutlet weak var Command: NSTextField!
    var gameIO : GameOutput?
    var game : Game?
    
/*
    override init() {
        super.init()
    }
*/
    
    @IBAction func Command(sender: AnyObject) {
        if game!.execute(sender.stringValue) {
            game!.end()
        }
        Command.stringValue = ""
    }
    //What the notification will tell you before it terminates
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        let tv : NSTextView = Output.documentView as! NSTextView
        tv.editable = false
        gameIO = GameOutput(newOutput: Output.documentView as! NSTextView)
        game = Game(gameIO: gameIO!)
        game!.start()
        Command.becomeFirstResponder()
    }
    //What the notification will alert after termination
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

