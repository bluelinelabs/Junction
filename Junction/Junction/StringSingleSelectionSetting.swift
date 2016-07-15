//
//  SingleSelectionSetting.swift
//  Junction
//
//  Created by Jimmy McDermott on 7/5/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public final class StringSingleSelectionSection: SingleSelectionBase<String> {
    override func addCustomValue(value: String) {
        JunctionKeeper.sharedInstance.addValueToCustomOption("\(key)_customOption", value: value)
        rows.append(StringSetting(placeholder: nil, defaultValue: nil, key: key, value: value, title: nil))
        possibleValues.append(value)
    }
    
    public init(possibleValues: [String], enableCustom: Bool, name: String, key: String, defaultValue: Int) {
        super.init(possibleValues: possibleValues, enableCustom: enableCustom, name: name, key: key, defaultValue: possibleValues[defaultValue])
    }
}
