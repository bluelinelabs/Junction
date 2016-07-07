//
//  WaveKeeper.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/24/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import UIKit

internal final class WaveKeeper {
    internal static let sharedInstance = WaveKeeper()
    
    private init() { }
    
    private func createPlistIfNeeded() -> Bool {
        var exists = false
        let plist = "WaveData.plist"
        let fileManager = NSFileManager.defaultManager()
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let path = documentDirectory.stringByAppendingString("/\(plist)")
        
        if !fileManager.fileExistsAtPath(path) {
            let emptyData = NSDictionary(dictionary: [:])
            emptyData.writeToFile(path, atomically: true)
        } else{
            exists = true
        }
        
        return exists
    }
    
    internal func getValueWithKey(key: String) -> AnyObject? {
        self.createPlistIfNeeded()
        
        let filename = "WaveData.plist"
        
        guard let fileURL =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first?.URLByAppendingPathComponent(filename) else { return nil }
        
        guard let dict = NSDictionary(contentsOfURL: fileURL) else { return nil }
        return dict[key]
    }
    
    private func loadAllData() -> NSDictionary? {
        let filename = "WaveData.plist"
        
        guard let fileURL =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first?.URLByAppendingPathComponent(filename) else { return nil }
        
        guard let dict = NSDictionary(contentsOfURL: fileURL) else { return nil }
        return dict
    }
    
    internal func addValueForKey(key: String, value: AnyObject) -> Bool {
        self.createPlistIfNeeded()
        
        let filename = "WaveData.plist"
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let path = documentDirectory.stringByAppendingString("/\(filename)")
        
        let dictionary = NSDictionary(dictionary: [key: value])
        
        let previousValues = loadAllData()?.mutableCopy()
        
        previousValues?.addEntriesFromDictionary(dictionary as [NSObject : AnyObject])
        
        return previousValues!.writeToFile(path, atomically: true)
    }
}
