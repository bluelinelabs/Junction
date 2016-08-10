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
    
    private func getPath() -> String {
        let filename = "JunctionData.plist"
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        return documentDirectory.stringByAppendingString("/\(filename)")
    }
    
    private func createPlistIfNeeded() -> Bool {
        var exists = false
        let fileManager = NSFileManager.defaultManager()
        
        let path = JunctionKeeper.sharedInstance.getPath()
        
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
        
        let path = JunctionKeeper.sharedInstance.getPath()
        
        let previousValues = loadAllData()?.mutableCopy()

        if let previousValuesUnwrapped = previousValues?[key] as? NSArray {
            let newValuesToPass = previousValuesUnwrapped.arrayByAddingObject(value)
            previousValues?.addEntriesFromDictionary([key: newValuesToPass])
            
            return previousValues!.writeToFile(path, atomically: true)
        } else {
            let newValuesToPass = [value]

            previousValues?.addEntriesFromDictionary([key: newValuesToPass])
            
            return previousValues!.writeToFile(path, atomically: true)
        }
    }
    
    internal func addValueForKey(key: String, value: AnyObject) -> Bool {
        createPlistIfNeeded()
        
        let path = JunctionKeeper.sharedInstance.getPath()
        
        let dictionary = NSDictionary(dictionary: [key: value])
        
        let previousValues = loadAllData()?.mutableCopy()
        
        previousValues?.addEntriesFromDictionary(dictionary as [NSObject : AnyObject])
        
        return previousValues!.writeToFile(path, atomically: true)
    }
    
    internal func deleteValueFromArray(key: String, valueToDelete: AnyObject) -> Bool {
        createPlistIfNeeded()
        
        let path = JunctionKeeper.sharedInstance.getPath()
        
        if let previousValues = loadAllData()?.mutableCopy() as? NSDictionary {
            if var valuesForKey = previousValues[key] as? [AnyObject] {
                let index = valuesForKey.indexOf({ (object) -> Bool in
                    return object.isEqual(valueToDelete)
                })
                
                if let index = index {
                    let previous = loadAllData()?.mutableCopy()
                    valuesForKey.removeAtIndex(index)
                    
                    previous?.addEntriesFromDictionary([key: valuesForKey])
                    previous?.writeToFile(path, atomically: true)
                }
            }
        }
        
        return false
    }
}
