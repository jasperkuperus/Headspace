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
    @IBOutlet weak var launchAtLogin: NSMenuItem!
    @IBOutlet weak var isTemplate: NSMenuItem!

    let icon = NSImage(named: NSImage.Name("statusIcon"))

    let statusItem =  NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    let userDefaults = UserDefaults.standard

    func getStartAtLogin() -> Bool {
        return userDefaults.bool(forKey: "startAtLogin")
    }
    
    func setStartAtLogin(startAtLogin: Bool) {
        userDefaults.set(startAtLogin, forKey: "startAtLogin")
    }

    func getIsTemplate() -> Bool {
        return userDefaults.bool(forKey: "isTemplate")
    }
    
    func setIsTemplate(isTemplate: Bool) {
        userDefaults.set(isTemplate, forKey: "isTemplate")
    }

    func setLaunchAtLoginCheck(isChecked: Bool) {
        if (isChecked) {
            launchAtLogin.state = NSControl.StateValue.on
        } else {
            launchAtLogin.state = NSControl.StateValue.off
        }
    }
    
    func setIsTemplateCheck(isChecked: Bool) {
        if (isChecked) {
            isTemplate.state = NSControl.StateValue.on
        } else {
            isTemplate.state = NSControl.StateValue.off
        }
    }

    @IBAction func launchAtLoginClicked(_ sender: NSMenuItem) {
        if (getStartAtLogin()) {
            setStartAtLogin(startAtLogin: false)
            setLaunchAtLoginCheck(isChecked: false)
        } else {
            setStartAtLogin(startAtLogin: true)
            setLaunchAtLoginCheck(isChecked: true)
        }
    }
    
    @IBAction func isTemplateClicked(_ sender: NSMenuItem) {
        if (getIsTemplate()) {
            setIsTemplate(isTemplate: false)
            setIsTemplateCheck(isChecked: false)
            icon?.isTemplate = false
        } else {
            setIsTemplate(isTemplate: true)
            setIsTemplateCheck(isChecked: true)
            icon?.isTemplate = true
        }
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.menu = statusMenu
        statusItem.image = icon
        statusItem.menu = statusMenu

        if (getIsTemplate()) {
            icon?.isTemplate = true
            setIsTemplateCheck(isChecked: true)
        }
        
        if (getStartAtLogin()) {
            setLaunchAtLoginCheck(isChecked: true)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

