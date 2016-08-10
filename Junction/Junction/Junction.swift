//
//  Junction.swift
//  Junction
//
//  Created by Jimmy McDermott on 7/7/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public final class Junction {
    
    public typealias SettingsCallback = (previousValues: NSDictionary, newValues: NSDictionary) -> Void
    
    public static var settingsUpdatedBlock: SettingsCallback? = nil
    
    public static var style: PresentationStyle = .Shake
    private static var sections: [SectionType]!
    private static var debugMode = false
    
    public static func createWindow(frame: CGRect, setup: JunctionSetup) -> UIWindow {
        sections = setup.sections()
        debugMode = setup.debugMode
        return JunctionWindow(frame: frame, style: style, sections: sections, enabled: debugMode)
    }
    
    public static func valueForKey(key: String, productionValue: AnyObject?) -> AnyObject? {
        if debugMode {
            return JunctionKeeper.sharedInstance.getValueWithKey(key)
        } else {
            return productionValue
        }
    }
}
