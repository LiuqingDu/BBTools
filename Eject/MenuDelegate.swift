//
//  MenuDelegate.swift
//  NewFile
//
//  Created by Tong on 2018/9/19.
//  Copyright © 2018 BB. All rights reserved.
//

import Cocoa

class MenuDelegate: NSObject, NSMenuDelegate {
    
    func menuWillOpen(_ menu: NSMenu) {
        reloadList(menu)
    }
    
    /// 重新加载设备列表
    ///
    /// - Parameter menu: 状态栏菜单
    private func reloadList(_ menu: NSMenu) {
        
        // 清空列表
        menu.removeAllItems()
        
        menu.addItem(withTitle: "点击名称推出设备", action: #selector(AppDelegate.createFile(_:)), keyEquivalent: "")
        menu.addItem(NSMenuItem.separator())
        
        // 设置设备图标
        let img = NSImage(named: "hdd")
        img?.isTemplate = true
        
        // 获取设备列表
        let urls = fm.mountedVolumeURLs(includingResourceValuesForKeys: nil, options: .skipHiddenVolumes)
        for url in urls! {
            let item = NSMenuItem(title: url.lastPathComponent, action: #selector(AppDelegate.eject(_:)), keyEquivalent: "")
            item.image = img
            menu.addItem(item)
        }
        
        // 退出选项
        menu.addItem(NSMenuItem.separator())
        menu.addItem(withTitle: "退出", action: #selector(AppDelegate.quitApp(_:)), keyEquivalent: "")
        
    }
    
}
