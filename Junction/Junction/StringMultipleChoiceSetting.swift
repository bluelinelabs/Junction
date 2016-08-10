//
//  SingleSelectionSetting.swift
//  Junction
//
//  Created by Jimmy McDermott on 7/5/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public final class StringMultipleChoiceSetting: MultipleChoiceBase<String> {
    override func addCustomValue(value: String) {
        let options = JunctionKeeper.sharedInstance.getValueWithKey(key.customOption)
        
        if let options = options as? [String] {
            if !options.contains(value) {
                JunctionKeeper.sharedInstance.addValueToArray(key.customOption, value: value)
                rows.append(StringSetting(placeholder: nil, defaultValue: nil, key: key, value: value, title: nil))
                possibleValues.append(MultipleChoiceOption(value: value, isInitialValue: false))
            }
        } else {
            JunctionKeeper.sharedInstance.addValueToArray(key.customOption, value: value)
            rows.append(StringSetting(placeholder: nil, defaultValue: nil, key: key, value: value, title: nil))
            possibleValues.append(MultipleChoiceOption(value: value, isInitialValue: false))
        }
    }
    
    public override init(possibleValues: [MultipleChoiceOption<String>], customOption: CustomOption, name: String, key: String, isMultiSelect: Bool) {
        
        if (possibleValues.filter { $0.isInitialValue }).count > 1 {
            fatalError("You cannot specify more than one initial value")
        } else {
            super.init(possibleValues: possibleValues, customOption: customOption, name: name, key: key, isMultiSelect: isMultiSelect)
        }
    }
}
