//
//  AppDelegate.swift
//  Headspace
//
//  Created by Jasper Kuperus on 17/06/2018.
//  Copyright © 2018 Jasper Kuperus. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem =  NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.menu = statusMenu
        let icon = NSImage(named: NSImage.Name("statusIcon"))
//        icon?.isTemplate = true
        statusItem.image = icon
        statusItem.menu = statusMenu
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

