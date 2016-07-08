//
//  Wave.swift
//  Wave
//
//  Created by Jimmy McDermott on 7/7/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public final class Wave {
    public static let sharedInstance = Wave()
    
    private init() { }
    
    public func valueForKey(key: String) -> AnyObject? {
        return WaveKeeper.sharedInstance.getValueWithKey(key)
    }
}
