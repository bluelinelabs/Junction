//
//  WaveDebug.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/24/16.
//  Copyright © 2016 Blue Line Labs. All rights reserved.
//

import Foundation

final public class WaveDebug {
    private class func userIsInSimulator() -> Bool {
        #if (arch(i386) || arch(x86_64))
            return true
        #else
            return false
        #endif
    }
    
    private class func userIsOnDebug() -> Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    public class func shouldDisplayWave() -> Bool {
        
        //Return true if any of the following are true
        //1. User is running simulator and on debug
        //2. User is in simulator but not running debug (open for debate)
        //3. User is not in the simulator but is running debug (on a personal device)
        
        if (userIsOnDebug() && userIsInSimulator()) || (!userIsInSimulator() && userIsOnDebug()) || (userIsInSimulator() && !userIsOnDebug()) {
            return true
        } else {
            return false
        }
    }
}
