//
//  SandBoxUtil.swift
//  ppts
//
//  Created by lichongbing on 2022/12/9.
//

import Foundation

class SandBoxUtil {
    
    // Get home path.
    static func homePath() -> String {
       return NSHomeDirectory();
    }

    // Get document path.
    static func documentPath() -> String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0];
    }

    // Get library path.
    static func libraryPath() -> String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    }

    // Get temp path.
    static func tempPath() -> String {
       return NSTemporaryDirectory()
    }

    // Get cache path.
    static func cachesPath() -> String {
        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0];
    }

    // Get prefrences path.
    static func perferencesPath() -> String {
        let lib = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
       return lib + "/Preferences"
    }

}

