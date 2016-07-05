//
//  SingleSelectionSetting.swift
//  Wave
//
//  Created by Jimmy McDermott on 7/5/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public final class SingleSelectionSection: SectionType, SettingType {
    
    public var possibleValues: [Any]
    public var enableCustom = false
    public var customOption: RowType?
    public var name: String
    private var settings = [Setting]()
    
    public init(possibleValues: [Any], enableCustom: Bool, customOption: RowType?, name: String) {
        self.possibleValues = possibleValues
        self.enableCustom = enableCustom
        self.customOption = customOption
        self.name = name
        
        for value in self.possibleValues {
            self.settings.append(StringSetting(placeholder: nil, defaultValue: nil, key: "\(name)_\(value)", value: String(value), title: nil))
        }
        
    }
    
    public func registerCells(tableView: UITableView) {
        for setting in settings {
            setting.registerCells(tableView)
        }
    }
    
    public func numberOfRows() -> Int {
        if enableCustom {
            return possibleValues.count + 1
        } else {
            return possibleValues.count
        }
    }
    
    public func tableViewCellIdentifier(indexPath: NSIndexPath) -> String {
        return settings[indexPath.row].cellIdentifier
    }
    
    public func configureCell(cell: UITableViewCell, row: Int) {
        settings[row].configureCell(cell)
    }
    
    public func store() {
        
    }
}
