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
    
    public static var completionBlock: SettingsCallback? = nil
    
    private static var frame: CGRect!
    public static var style: PresentationStyle!
    public static var sections: [SectionType]!
    public static var enabled: Bool!
    
    public static func createWindow(frame: CGRect) -> UIWindow {
        return JunctionWindow(frame: frame, style: style, sections: sections, enabled: enabled)
    }
    
    public static func valueForKey(key: String) -> AnyObject? {
        return JunctionKeeper.sharedInstance.getValueWithKey(key)
    }
}
