//
//  IntSelectionSetting.swift
//  Junction
//
//  Created by Jimmy McDermott on 7/6/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public final class IntMultipleChoiceSetting: MultipleChoiceBase<Int> {
    override func addCustomValue(value: String) {
        guard let value = Int(value) else {
            return
        }
        
        let options = JunctionKeeper.sharedInstance.getValueWithKey(key.customOption)
        if let options = options as? [Int] {
            if !options.contains(value) {
                JunctionKeeper.sharedInstance.addValueToArray(key.customOption, value: value)
                rows.append(StringSetting(placeholder: nil, defaultValue: nil, key: key, value: String(value), title: nil))
                possibleValues.append(MultipleChoiceOption(value: value, isInitialValue: false))
            }
        } else {
            JunctionKeeper.sharedInstance.addValueToArray(key.customOption, value: value)
            rows.append(StringSetting(placeholder: nil, defaultValue: nil, key: key, value: String(value), title: nil))
            possibleValues.append(MultipleChoiceOption(value: value, isInitialValue: false))
        }
    }
    
    public override init(possibleValues: [MultipleChoiceOption<Int>], customOption: CustomOption, name: String, key: String, isMultiSelect: Bool) {
        super.init(possibleValues: possibleValues, customOption: customOption, name: name, key: key, isMultiSelect: isMultiSelect)
    }
}
