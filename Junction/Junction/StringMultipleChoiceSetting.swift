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
<<<<<<< Updated upstream
        JunctionKeeper.sharedInstance.addValueToCustomOption("\(key)_customOption", value: value)
        rows.append(StringSetting(placeholder: nil, defaultValue: value, key: key, title: nil))
=======
        JunctionKeeper.sharedInstance.addValueToArray("\(key)_customOption", value: value)
        rows.append(StringSetting(placeholder: nil, defaultValue: nil, key: key, value: value, title: nil))
>>>>>>> Stashed changes
        possibleValues.append(MultipleChoiceOption(value: value, isInitialValue: false))
    }
    
    public override init(possibleValues: [MultipleChoiceOption<String>], enableCustom: Bool, name: String, key: String, isMultiSelect: Bool) {
        
        if (possibleValues.filter { $0.isInitialValue }).count > 1 {
            fatalError("You cannot specify more than one initial value")
        } else {
            super.init(possibleValues: possibleValues, enableCustom: enableCustom, name: name, key: key, isMultiSelect: isMultiSelect)
        }
    }
}
