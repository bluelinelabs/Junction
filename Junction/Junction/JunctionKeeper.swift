//
//  JunctionKeeper.swift
//  Junction
//
//  Created by Jimmy McDermott on 6/24/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import UIKit

internal final class JunctionKeeper {
    internal static let sharedInstance = JunctionKeeper()
    
    private init() { }
    
    private func createPlistIfNeeded() -> Bool {
        var exists = false
        let plist = "JunctionData.plist"
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
        createPlistIfNeeded()
        
        let filename = "JunctionData.plist"
        
        guard let fileURL =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first?.URLByAppendingPathComponent(filename) else { return nil }
        
        return NSDictionary(contentsOfURL: fileURL)?[key]
    }
    
    internal func loadAllData() -> NSDictionary? {
        let filename = "JunctionData.plist"
        
        guard let fileURL =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first?.URLByAppendingPathComponent(filename) else { return nil }
        
        guard let dict = NSDictionary(contentsOfURL: fileURL) else { return nil }
        return dict
    }
    
    internal func addValueToArray(key: String, value: AnyObject) -> Bool {
        createPlistIfNeeded()
        
        let filename = "JunctionData.plist"
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let path = documentDirectory.stringByAppendingString("/\(filename)")
        
        guard let previousArrayValues = loadAllData()![key] else {
            return addValueForKey(key, value: [value])
        }
        
        let previousValues = loadAllData()?.mutableCopy()
        
        if !previousArrayValues.containsObject(value) {
            previousArrayValues.addObject(value)
        }
        
        let dictionary = NSDictionary(dictionary: [key: previousArrayValues])
        
        previousValues?.addEntriesFromDictionary(dictionary as [NSObject: AnyObject])
        
        return previousValues!.writeToFile(path, atomically: true)
    }
    
    internal func addValueForKey(key: String, value: AnyObject) -> Bool {
        createPlistIfNeeded()
        
        let filename = "JunctionData.plist"
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let path = documentDirectory.stringByAppendingString("/\(filename)")
        
        let dictionary = NSDictionary(dictionary: [key: value])
        
        let previousValues = loadAllData()?.mutableCopy()
        
        previousValues?.addEntriesFromDictionary(dictionary as [NSObject : AnyObject])
        
        return previousValues!.writeToFile(path, atomically: true)
    }
}
