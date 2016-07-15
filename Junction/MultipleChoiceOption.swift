//
//  MultipleSelectionObject.swift
//  Junction
//
//  Created by Jimmy McDermott on 7/15/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public class MultipleChoiceOption<T: Any> {
    
    internal var value: T
    internal var isInitialValue: Bool
    
    public init(value: T, isInitialValue: Bool) {
        self.value = value
        self.isInitialValue = isInitialValue
    }
}
