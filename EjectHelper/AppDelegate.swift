//
//  AppDelegate.swift
//  EjectHelper
//
//  Created by Tong on 2018/9/20.
//  Copyright © 2018 BB. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let mainAppIdentifier = "com.duliuqing.BBTools.Eject"
        let running           = NSWorkspace.shared.runningApplications
        var alreadyRunning    = false
        for app in running {
            if app.bundleIdentifier == mainAppIdentifier {
                alreadyRunning = true
                break
            }
        }
        if !alreadyRunning {
            //DistributedNotificationCenter.default().addObserver(self, selector: #selector("terminate"), name: "killhelper", object: mainAppIdentifier)
            let path = Bundle.main.bundlePath as NSString
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("Eject") //main app name
            let newPath = NSString.path(withComponents: components)
            NSWorkspace.shared.launchApplication(newPath)
        } else {
            self.terminate()
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func terminate() {
        //      NSLog("I'll be back!")
        NSApp.terminate(nil)
    }
    
}

