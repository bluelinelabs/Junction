//
//  StringSetting.swift
//  Junction
//
//  Created by Jimmy McDermott on 7/5/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation
import UIKit

public final class StringSetting: Setting {
    public var placeholder: String?
    public var defaultValue: String?
    public var value: String
    public var key: String
    
    public init(placeholder: String?, defaultValue: String?, key: String, value: String, title: String?) {
        self.placeholder = placeholder
        self.defaultValue = defaultValue
        self.key = key
        self.value = value
        
        super.init()
        self.title = title
    }
    
    public override func configureCell(tableViewCell: UITableViewCell) {
        super.configureCell(tableViewCell)
        
        if let cell = tableViewCell as? LabelTableViewCell {
            cell.label.text = "\(cell.label.text!) \(value)"
        }
    }
    
    override public func store() {
        JunctionKeeper.sharedInstance.addValueForKey(key, value: value)
    }
    
    public override func canSwipeToDelete() -> Bool {
        return false
    }
}
