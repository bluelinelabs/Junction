//
//  SingleSelectionSetting.swift
//  Junction
//
//  Created by Jimmy McDermott on 7/5/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public final class StringMultipleSelectionSetting: MultipleSelectionBase<String> {
    override func addCustomValue(value: String) {
        JunctionKeeper.sharedInstance.addValueToCustomOption("\(key)_customOption", value: value)
        rows.append(StringSetting(placeholder: nil, defaultValue: nil, key: key, value: value, title: nil))
        possibleValues.append(value)
    }
    
    public init(possibleValues: [String], enableCustom: Bool, name: String, key: String, defaultIndex: Int) {
        guard defaultIndex < possibleValues.count else {
            fatalError("default value must be the index of a possible value, and therefore cannot be greater than or equal to possibleValues.count")
        }
        
        super.init(possibleValues: possibleValues, enableCustom: enableCustom, name: name, key: key, defaultValue: possibleValues[defaultIndex])
    }
}
