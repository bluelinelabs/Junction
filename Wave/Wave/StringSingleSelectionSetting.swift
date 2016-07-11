//
//  SingleSelectionSetting.swift
//  Wave
//
//  Created by Jimmy McDermott on 7/5/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public final class StringSingleSelectionSection: SectionType, SettingType {
    
    public var possibleValues: [String]
    public var enableCustom = false
    public var name: String
    private var settings = [StringSetting]()
    private var selectedSetting: StringSetting?
    private var key: String
    public var sectionDelegate: WaveDelegate?
    
    public init(possibleValues: [String], enableCustom: Bool, name: String, key: String) {
        self.possibleValues = possibleValues
        self.enableCustom = enableCustom
        self.name = name
        self.key = key
        
        for value in possibleValues {
            settings.append(StringSetting(placeholder: nil, defaultValue: nil, key: key, value: String(value), title: nil))
        }
        
        if enableCustom {
            settings.append(StringSetting(placeholder: nil, defaultValue: nil, key: "\(key)_customOption", value: "Custom Option", title: "Custom Option"))
        }
    }
    
    public func getSettings() -> [Setting] {
        return settings
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
    
    public func addSetting(text: String, key: String) {
        
    }
    
    public func tableViewCellIdentifier(indexPath: NSIndexPath) -> String {
        return settings[indexPath.row].cellIdentifier
    }
    
    public func configureCell(cell: UITableViewCell, row: Int) {
        cell.textLabel!.text = settings[row].value
        
        guard let selectedOption = WaveKeeper.sharedInstance.getValueWithKey(key) as? String else {
            return
        }
        
        guard row < possibleValues.count else {
            return
        }
        
        if selectedOption == possibleValues[row] {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
    }

    public func store() {
        
        guard let selectedSetting = selectedSetting else {
            return
        }
        
        selectedSetting.store()
    }
    
    private func customOptionTapped(tableView: UITableView, section: Int) {
        
    }
    
    public func didSelectCell(tableViewCell: UITableViewCell, tableView: UITableView, indexPath: NSIndexPath) {
        settings[indexPath.row].didSelectCell(tableViewCell, tableView: tableView, indexPath: indexPath)
        
        guard settings[indexPath.row].value != "Custom Option" else {
            customOptionTapped(tableView, section: indexPath.section)
            return
        }
        
        selectedSetting = settings[indexPath.row]
        store()
         
        configureCell(tableViewCell, row: indexPath.row)
        tableView.reloadData()
    }
}
