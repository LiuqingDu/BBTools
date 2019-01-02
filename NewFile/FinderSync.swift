//
//  FinderSync.swift
//  NewFile
//
//  Created by Tong on 2018/9/20.
//  Copyright © 2018 BB. All rights reserved.
//

import Cocoa
import FinderSync

class FinderSync: FIFinderSync {

    // 生效的监视路径
    var myFolderURL = URL(fileURLWithPath: "/")
    
    let newFileBaseName = "new file"
    let newFileExtension = "txt"
    
    // 扩展的右键菜单
    let extMenu = NSMenu(title: "")
    
    override init() {
        super.init()
        
        // 设置监视路径
        FIFinderSyncController.default().directoryURLs = [self.myFolderURL]
        
        // 右键菜单项
        let item = NSMenuItem(title: "新建文件", action: nil, keyEquivalent: "")
        // 设置菜单项下的菜单
        item.submenu = extSubMenu
        
        // 将右键菜单加入扩展
        extMenu.addItem(item)
    }
    
    override func menu(for menu: FIMenuKind) -> NSMenu? {
        // Produce a menu for the extension.
        reloadMenu()
        
        return extMenu
    }
    
    /// 创建子菜单
    func reloadMenu() {
        
        extSubMenu.removeAllItems()
        
        extSubMenu.addItem(withTitle: "新建文本文档", action: #selector(createFile(_:)), keyEquivalent: "")
    }
    
    @IBAction func createFile(_ sender: NSMenuItem) {
        
//        let target = FIFinderSyncController.default().targetedURL()
//        let items = FIFinderSyncController.default().selectedItemURLs()
        
        guard let folderURL = FIFinderSyncController.default().targetedURL() else { return }
        
        let fileManager = FileManager.default
        
        do {
            let contentsOfDirectory = try fileManager.contentsOfDirectory(
                at: folderURL,
                includingPropertiesForKeys: nil,
                options: .skipsHiddenFiles
            )
            
            let newFileNameGenerator = NewFileNameGenerator(newFileBaseName, newFileExtension)
            let newFileName = newFileNameGenerator.genNewFileName(for: contentsOfDirectory)
            
            let newFileURL = folderURL
                .appendingPathComponent(newFileName)
                .appendingPathExtension(newFileExtension)
            
            // Write blank file to disk.
            fileManager.createFile(atPath: newFileURL.relativeString, contents: nil, attributes: nil)
            
        } catch {
            print(error)
            return
        }
    }

}
