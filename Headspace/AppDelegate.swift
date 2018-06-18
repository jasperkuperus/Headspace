//
//  AppDelegate.swift
//  Headspace
//
//  Created by Jasper Kuperus on 17/06/2018.
//  Copyright © 2018 Jasper Kuperus. All rights reserved.
//

import Cocoa
import ServiceManagement

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

    func getIsTemplate() -> Bool {
        return userDefaults.bool(forKey: "isTemplate")
    }

    func setStartAtLogin(shouldStartAtLogin: Bool) {
        userDefaults.set(shouldStartAtLogin, forKey: "startAtLogin")

        if (shouldStartAtLogin) {
            launchAtLogin.state = NSControl.StateValue.on
        } else {
            launchAtLogin.state = NSControl.StateValue.off
        }
    }
    
    func setIsTemplate(isTemplateValue: Bool) {
        userDefaults.set(isTemplateValue, forKey: "isTemplate")

        if (isTemplateValue) {
            isTemplate.state = NSControl.StateValue.on
            icon?.isTemplate = true
        } else {
            isTemplate.state = NSControl.StateValue.off
            icon?.isTemplate = false
        }
    }

    func toggleLoginItem(shouldStartAtLogin: Bool) {
        let appId = "nl.qscope.HeadspaceHelper" as CFString
        if (SMLoginItemSetEnabled(appId, shouldStartAtLogin)) {
            if (shouldStartAtLogin) {
                NSLog("Successfully add login item.")
            } else {
                NSLog("Successfully remove login item.")
            }
        } else {
            NSLog("Failed to add login item.")
        }
    }
    
    @IBAction func launchAtLoginClicked(_ sender: NSMenuItem) {
        let currentState = getStartAtLogin()
        setStartAtLogin(shouldStartAtLogin: !currentState)
        toggleLoginItem(shouldStartAtLogin: !currentState)
    }
    
    @IBAction func isTemplateClicked(_ sender: NSMenuItem) {
        setIsTemplate(isTemplateValue: !getIsTemplate())
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.menu = statusMenu
        statusItem.image = icon
        statusItem.menu = statusMenu

        setIsTemplate(isTemplateValue: getIsTemplate())
        setStartAtLogin(shouldStartAtLogin: getStartAtLogin())
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

