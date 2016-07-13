//
//  IntSetting.swift
//  Wave
//
//  Created by Jimmy McDermott on 7/5/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation
import UIKit

public final class IntSetting: Setting {
    public var defaultValue: String?
    public var value: Int
    public var key: String
    
    public init(defaultValue: String?, value: Int, key: String, title: String?) {
        self.defaultValue = defaultValue
        self.value = value
        self.key = key
        
        super.init()
        self.title = title
    }
    
    override public func configureCell(tableViewCell: UITableViewCell) {
        super.configureCell(tableViewCell)

        tableViewCell.textLabel!.text = "\(tableViewCell.textLabel!.text!) \(value)"
    }

    override public func store() {
        WaveKeeper.sharedInstance.addValueForKey(key, value: value)
    }
}
