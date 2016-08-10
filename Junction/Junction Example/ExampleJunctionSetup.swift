//
//  ExampleJunctionSetup.swift
//  Junction
//
//  Created by Jimmy McDermott on 8/10/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation
import Junction

class ExampleJunctionSetup: JunctionSetup {
    
    var debugMode = true
    
    func sections() -> [SectionType] {
        let stringSetting = StringSetting(placeholder: "", defaultValue: nil, key: "mainEndpoint", value: "https://www.google.com", title: "Main Endpoint:")
        let intSetting = IntSetting(defaultValue: nil, value: 8080, key: "port", title: "Port")
        
        let firstSection = Section(name: "Endpoints")
            .addRow(stringSetting)
            .addRow(intSetting)
        
        let multipleSelectionOptions = [MultipleChoiceOption<String>(value: "google.com", isInitialValue: true), MultipleChoiceOption<String>(value: "yahoo.com", isInitialValue: false)]
        let intMultipleSelectionOptions = [MultipleChoiceOption<Int>(value: 1, isInitialValue: true), MultipleChoiceOption<Int>(value: 2, isInitialValue: true)]
        
        let secondSection = StringMultipleChoiceSetting(possibleValues: multipleSelectionOptions, customOption: .Custom("Add Endpoint"), name: "Single Selection String", key: "singleSelectionString", isMultiSelect: true)
        let thirdSection = IntMultipleChoiceSetting(possibleValues: intMultipleSelectionOptions, customOption: .None, name: "Single Selection Int", key: "singleSelectionInt", isMultiSelect: false)
        
        return [firstSection, secondSection, thirdSection]
    }
}
