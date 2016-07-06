//
//  WaveKeeper.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/24/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import UIKit

public final class WaveKeeper {
    public static let sharedInstance = WaveKeeper()
    
    private init() { }
    
    private func createPlistIfNeeded() -> Bool {
        var exists = false
        let plist = "WaveData.plist"
        let fileManager = NSFileManager.defaultManager()
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let path = documentDirectory.stringByAppendingString("/\(plist)")
        
        if(!fileManager.fileExistsAtPath(path)){
            let emptyData = NSDictionary(dictionary: [:])
            emptyData.writeToFile(path, atomically: true)
        } else{
            exists = true
        }
        
        return exists
    }
    
    public func valueForKey(key: String) -> AnyObject? {
        let name = "WaveData"
        let plist = "\(name).plist"
        
        var sourcePath:String? {
            guard let path = NSBundle.mainBundle().pathForResource(plist, ofType: "plist") else { return nil }
            return path
        }
        
        var destPath: String? {
            guard sourcePath != .None else { return nil }
            let dir = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
            return (dir as NSString).stringByAppendingPathComponent("\(name).plist")
        }
        
        if !createPlistIfNeeded() {
            return nil
        } else {
            guard let dict = NSDictionary(contentsOfFile: plist) else { return nil }
            return dict[key]
        }
    }
}
