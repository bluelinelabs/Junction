//
//  Junction.swift
//  Junction
//
//  Created by Jimmy McDermott on 7/7/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation
import UIKit

public final class Junction {
    
    public typealias SettingsCallback = (previousValues: NSDictionary, newValues: NSDictionary) -> Void
    
    public static var settingsUpdatedBlock: SettingsCallback? = nil
    
    public static var style: PresentationStyle!
    public static var sections: [SectionType]!
    private static var debugMode = false
    
    public static func createWindow(frame: CGRect, debugMode: Bool) -> UIWindow {
        self.debugMode = debugMode
        return JunctionWindow(frame: frame, style: style, sections: sections, enabled: debugMode)
    }
    
    public static func valueForKey(key: String, productionValue: AnyObject?) -> AnyObject? {
        if debugMode {
            return JunctionKeeper.sharedInstance.getValueWithKey(key)
        } else {
            return productionValue
        }
    }
    
    public static func present() {
        if let window = UIApplication.sharedApplication().keyWindow as? JunctionWindow {
            window.presentJunction()
        }
    }
    
}
