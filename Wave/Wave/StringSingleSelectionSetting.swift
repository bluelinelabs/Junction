//
//  SingleSelectionSetting.swift
//  Wave
//
//  Created by Jimmy McDermott on 7/5/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public final class StringSingleSelectionSection: NSObject, SectionType, SettingType {
    
    public var possibleValues: [String]
    public var enableCustom = false
    public var name: String
    private var settings = [RowType]()
    private var selectedSetting: String?
    private var key: String
    public var sectionDelegate: WaveDelegate?
    private let inputCellIdentifier = "inputWaveCell"
    private let displayCellIdentifier = "waveCell"
    
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
            
            guard let customOptions = WaveKeeper.sharedInstance.getValueWithKey("\(key)_customOption") as? [String] else {
                return
            }
            
            for option in customOptions {
                self.possibleValues.append(option)
                settings.append(StringSetting(placeholder: nil, defaultValue: nil, key: key, value: option, title: nil))
            }
        }
    }
    
    public func registerCells(tableView: UITableView) {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: displayCellIdentifier)
        tableView.registerClass(InputTableViewCell.self, forCellReuseIdentifier: inputCellIdentifier)
    }
    
    public func numberOfRows() -> Int {
        if enableCustom {
            return possibleValues.count + 1
        } else {
            return possibleValues.count
        }
    }
    
    public func tableViewCellIdentifier(row: Int) -> String {
        if enableCustom && settings.count - 1 == row {
            return inputCellIdentifier
        } else {
            return displayCellIdentifier
        }
    }
    
    public func configureCell(cell: UITableViewCell, row: Int) {
        
        if let inputCell = cell as? InputTableViewCell {
            inputCell.textField.delegate = self
        }
        
        guard row < possibleValues.count else {
            return
        }
        
        cell.textLabel!.text = possibleValues[row]
        
        guard let selectedOption = WaveKeeper.sharedInstance.getValueWithKey(key) as? String else {
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
        
        WaveKeeper.sharedInstance.addValueForKey(key, value: selectedSetting)
    }
    
    public func didSelectCell(tableViewCell: UITableViewCell, tableView: UITableView, indexPath: NSIndexPath) {
        settings[indexPath.row].didSelectCell(tableViewCell, tableView: tableView, indexPath: indexPath)
        
        if tableViewCellIdentifier(indexPath.row) == displayCellIdentifier {
            selectedSetting = possibleValues[indexPath.row]
            store()
            
            configureCell(tableViewCell, row: indexPath.row)
            tableView.reloadData()
        }
    }
}

extension StringSingleSelectionSection: UITextFieldDelegate {
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField.text != nil && textField.text != "" {
            WaveKeeper.sharedInstance.addValueToCustomOption("\(key)_customOption", value: textField.text!)
            possibleValues.append(textField.text!)
            settings.append(StringSetting(placeholder: nil, defaultValue: nil, key: key, value: textField.text!, title: nil))
        }
        
        textField.text = nil
        
        self.sectionDelegate?.editsMade!()
        return true
    }
}
