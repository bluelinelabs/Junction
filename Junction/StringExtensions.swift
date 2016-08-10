//
//  StringExtensions.swift
//  Junction
//
//  Created by Jimmy McDermott on 8/10/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

internal extension String {
    var customOption: String {
        get {
            return "\(self)_customOption"
        }
    }
    
    var multiSelect: String {
        get {
            return "\(self)_multiSelect"
        }
    }
}
