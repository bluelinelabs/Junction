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
        let options = JunctionKeeper.sharedInstance.getValueWithKey("\(key)_customOption")
        if let options = options as? [String] {
            if !options.contains(value) {
                JunctionKeeper.sharedInstance.addValueToArray("\(key)_customOption", value: value)
                rows.append(StringSetting(placeholder: nil, defaultValue: nil, key: key, value: value, title: nil))
                possibleValues.append(MultipleChoiceOption(value: value, isInitialValue: false))
            }
        } else if options == nil {
            JunctionKeeper.sharedInstance.addValueToArray("\(key)_customOption", value: value)
        }
    }
    
    public override init(possibleValues: [MultipleChoiceOption<String>], enableCustom: Bool, name: String, key: String, isMultiSelect: Bool) {
        
        if (possibleValues.filter { $0.isInitialValue }).count > 1 {
            fatalError("You cannot specify more than one initial value")
        } else {
            super.init(possibleValues: possibleValues, enableCustom: enableCustom, name: name, key: key, isMultiSelect: isMultiSelect)
        }
    }
}
