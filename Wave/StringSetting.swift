//
//  StringSetting.swift
//  Wave
//
//  Created by Jimmy McDermott on 7/5/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public final class StringSetting: Setting<String> {
    public var placeholder: String
    
    public init(placeholder: String, defaultValue: String?, key: String) {
        self.placeholder = placeholder
        
        super.init()
        
        self.defaultValue = defaultValue
        self.key = key
    }
}
