//
//  IntSelectionSetting.swift
//  Wave
//
//  Created by Jimmy McDermott on 7/6/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public final class IntSingleSelectionSetting: SectionType, SettingType {
    public var possibleValues: [Int]
    public var enableCustom = false
    public var name: String
    private var settings = [Setting]()
    
    public init(possibleValues: [Int], enableCustom: Bool, name: String) {
        self.possibleValues = possibleValues
        self.enableCustom = enableCustom
        self.name = name
        
        for value in possibleValues {
            settings.append(IntSetting(defaultValue: nil, value: value, key: "\(name)_\(value)", title: nil))
        }
        
        if enableCustom {
            settings.append(StringSetting(placeholder: nil, defaultValue: nil, key: "", value: "Custom Option", title: nil))
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
        var value: AnyObject!
        
        if let intSetting = settings[row] as? IntSetting {
            value = intSetting.value
        } else if let stringSetting = settings[row] as? StringSetting {
            value = stringSetting.value
        }
        
        cell.textLabel!.text = String(value)
        
        if row == 0 {
            cell.accessoryType = .Checkmark
        }
    }
    
    public func store() {
        
    }

    public func didSelectCell(tableViewCell: UITableViewCell, tableView: UITableView, indexPath: NSIndexPath) {
        settings[indexPath.row].didSelectCell(tableViewCell, tableView: tableView, indexPath: indexPath)
    }
}