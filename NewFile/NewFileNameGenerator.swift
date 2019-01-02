//
//  NewFileNameGenerator.swift
//  NewFile
//
//  Created by Tong on 2018/9/20.
//  Copyright © 2018 BB. All rights reserved.
//

import Foundation

public struct NewFileNameGenerator {
    
    private let fileBaseName: String
    private let fileExtension: String
    
    public init(_ fileBaseName: String, _ fileExtension: String) {
        self.fileBaseName = fileBaseName
        self.fileExtension = fileExtension
    }
    
    /// 生成一个可用的文件名
    ///
    /// - Parameter contentsOfDirectory: 新建文件的路径
    /// - Returns: 可用的文件名
    public func genNewFileName(for contentsOfDirectory: [URL]) -> String {
        
        // 获取所有以 baseName 开头且同后缀的文件路径
        let existingFileURLs = contentsOfDirectory.filter({
            $0.lastPathComponent.hasPrefix(fileBaseName) && $0.pathExtension == fileExtension
        })
        
        // 获取文件名
        let existingFileNames = existingFileURLs.map({ $0.deletingPathExtension().lastPathComponent })
        
        // 依次遍历,找到可用的文件名
        var iteration = 0
        var newFileName = fileBaseName
        
        while existingFileNames.contains(newFileName) {
            iteration += 1
            newFileName = "\(fileBaseName) \(iteration)"
        }
        
        return newFileName
    }
}
