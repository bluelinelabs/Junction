//
//  IntSelectionSetting.swift
//  Wave
//
//  Created by Jimmy McDermott on 7/6/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public final class IntSingleSelectionSetting: SingleSelectionBase<Int> {
    override func addCustomValue(value: String) {
        guard let value = Int(value) else {
            return
        }
        
        WaveKeeper.sharedInstance.addValueToCustomOption("\(key)_customOption", value: value)
        rows.append(StringSetting(placeholder: nil, defaultValue: nil, key: key, value: String(value), title: nil))
        possibleValues.append(value)
    }
    
    public override init(possibleValues: [Int], enableCustom: Bool, name: String, key: String) {
        super.init(possibleValues: possibleValues, enableCustom: enableCustom, name: name, key: key)
    }
}
