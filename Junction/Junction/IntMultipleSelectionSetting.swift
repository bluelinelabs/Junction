//
//  IntSelectionSetting.swift
//  Junction
//
//  Created by Jimmy McDermott on 7/6/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public final class IntMultipleSelectionSetting: MultipleSelectionBase<Int> {
    override func addCustomValue(value: String) {
        guard let value = Int(value) else {
            return
        }
        
        JunctionKeeper.sharedInstance.addValueToCustomOption("\(key)_customOption", value: value)
        rows.append(StringSetting(placeholder: nil, defaultValue: nil, key: key, value: String(value), title: nil))
        possibleValues.append(value)
    }
    
    public init(possibleValues: [Int], enableCustom: Bool, name: String, key: String, defaultValue: Int) {
        super.init(possibleValues: possibleValues, enableCustom: enableCustom, name: name, key: key, defaultValue: possibleValues[defaultValue])
    }
}
