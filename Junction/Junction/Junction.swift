//
//  Junction.swift
//  Junction
//
//  Created by Jimmy McDermott on 7/7/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public final class Junction {
    
    public init() { }
    
    private var frame: CGRect!
    public var style: PresentationStyle!
    public var sections: [SectionType]!
    public var enabled: Bool!
    
    public func createWindow(frame: CGRect) -> UIWindow {
        return JunctionWindow(frame: frame, style: style, sections: sections, enabled: enabled)
    }
    
    public func valueForKey(key: String) -> AnyObject? {
        return JunctionKeeper.sharedInstance.getValueWithKey(key)
    }
}
