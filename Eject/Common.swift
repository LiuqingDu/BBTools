//
//  Shared.swift
//  NewFile
//
//  Created by Tong on 2018/9/19.
//  Copyright © 2018 BB. All rights reserved.
//

import Cocoa

// 状态栏图标
let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
// 状态栏菜单
let subMenu = NSMenu(title: "")

// FileManager 用于控制弹出设备
let fm = FileManager.default

// 菜单代理,用于显示菜单时更新菜单项
let menuDelegate = MenuDelegate()
