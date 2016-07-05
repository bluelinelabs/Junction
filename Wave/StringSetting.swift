//
//  StringSetting.swift
//  Wave
//
//  Created by Jimmy McDermott on 7/5/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

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
        
        tableViewCell.textLabel?.text = (tableViewCell.textLabel?.text)! + " test"
    }
    
    override public func store() {
        
    }
}
