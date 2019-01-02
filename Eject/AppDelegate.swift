//
//  AppDelegate.swift
//  NewFile
//
//  Created by Tong on 2018/9/18.
//  Copyright © 2018 BB. All rights reserved.
//

import Cocoa
import ServiceManagement

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        // 初始化状态栏
        initStatusBar()
        
        //startupAppWhenLogin(startup: true)
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    /// 初始化状态栏
    func initStatusBar() {
        // 设置状态栏
        let img = NSImage(named: "status")
        img?.isTemplate = true
        statusItem.button?.image = img
        
        subMenu.delegate = menuDelegate
        
        statusItem.menu = subMenu
    }
    
    /// 退出程序
    @IBAction func quitApp(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    /// 推出设备
    ///
    /// - Parameter sender: 触发此方法的菜单项
    @IBAction func eject(_ sender:NSMenuItem) {
        let unurl = URL(fileURLWithPath: "/Volumes/" + sender.title + "/")
        fm.unmountVolume(at: unurl, options: .allPartitionsAndEjectDisk) { (err) in
            if (err != nil) {
                print(err!)
            }
            else {
                self.notice(unurl.lastPathComponent)
            }
        }
    }
    
    @IBAction func createFile(_ sender: NSMenuItem) {
        
        print("create")
        var unurl = URL(fileURLWithPath: "/Volumes/" + "牛虫之盘" + "/")
        unurl.appendPathComponent("new")
        unurl.appendPathExtension("txt")
        
        var path = fm.currentDirectoryPath
        path += "/new.txt"
        print(path)
        print(fm.createFile(atPath: path, contents: nil, attributes: nil))
    }
    
    /// 通知中心发送消息
    ///
    /// - Parameter volumeName: 消息内容
    func notice(_ volumeName: String) {
        
        let userNotification = NSUserNotification()
        userNotification.title = "成功推出设备"
        userNotification.informativeText = volumeName
        // 使用NSUserNotificationCenter发送NSUserNotification
        let userNotificationCenter = NSUserNotificationCenter.default
        userNotificationCenter.scheduleNotification(userNotification)
        
    }
    
    /// 调用Helper实现开机自动启动
    ///
    /// - Parameter startup: 是否开机自动启动
    func startupAppWhenLogin(startup: Bool) {
        // 这里请填写你自己的Heler BundleID
        let launcherAppIdentifier = "com.duliuqing.BBTools.Helper"
        // 开始注册/取消启动项
        SMLoginItemSetEnabled(launcherAppIdentifier as CFString, startup)
        var startedAtLogin = false
        for app in NSWorkspace.shared.runningApplications {
            if app.bundleIdentifier == launcherAppIdentifier {
                startedAtLogin = true
            }
        }
        if startedAtLogin {
            //DistributedNotificationCenter.default().post("killhelper", object: CFBundleGetMainBundle().unsafelyUnwrapped)
        }
    }
    
}
