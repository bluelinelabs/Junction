//
//  Junction.swift
//  Junction
//
//  Created by Jimmy McDermott on 7/7/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public final class Junction {
    public static let sharedInstance = Junction()
    
    private init() { }
    
    public func valueForKey(key: String) -> AnyObject? {
        return JunctionKeeper.sharedInstance.getValueWithKey(key)
    }
}
