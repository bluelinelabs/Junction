//
//  SingleSelectionBase.swift
//  Junction
//
//  Created by Jimmy McDermott on 7/12/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation
import UIKit

//TODO: Make sure this supports only objects that can be serialized
public class MultipleChoiceBase<T: Any>: SectionType, SettingType {
    
    //we keep the following two arrays in sync because one manages the actual values, and one manages the actual cells
    public var possibleValues: [MultipleChoiceOption<T>]
    internal var rows = [RowType]()
    
    public var enableCustom = false
    public var name: String
    
    private var selectedOption: Int?
    private var selectedOptions = [Int]()
    
    internal var key: String
    public var sectionDelegate: SectionModifiedDelegate?
    
    private let inputCellIdentifier = "inputJunctionCell"
    private let displayCellIdentifier = "junctionCell"
    private var delegateProxy: UITextFieldDelegateProxy?
    private var defaultValue: MultipleChoiceOption<T>?
    private var isMultiSelect: Bool
    private var placeholder: String?
    
    //originalValues should never mutate past the init. We hold this reference so that we can cross reference it when we check for canSwipeToDelete
    private var originalValues: [MultipleChoiceOption<T>]
    
    public init(possibleValues: [MultipleChoiceOption<T>], customOption: CustomOption, name: String, key: String, isMultiSelect: Bool) {
        self.possibleValues = possibleValues
        
        switch customOption {
        case let .Custom(text):
            self.enableCustom = true
            placeholder = text
        default:
            self.enableCustom = false
        }

        self.name = name
        self.key = key
        self.isMultiSelect = isMultiSelect
        self.originalValues = possibleValues
        
        self.defaultValue = possibleValues.filter({ $0.isInitialValue }).first
        
        for value in possibleValues {
            rows.append(StringSetting(placeholder: nil, defaultValue: nil, key: key, value: String(value), title: nil))
        }
        
        if enableCustom {
            rows.append(StringSetting(placeholder: nil, defaultValue: nil, key: key.customOption, value: "Custom Option", title: "Custom Option"))
            
            if let customOptions = JunctionKeeper.sharedInstance.getValueWithKey(key.customOption) as? [T] {
                for option in customOptions {
                    let newMultipleSelectionObject = MultipleChoiceOption(value: option, isInitialValue: false)
                    self.possibleValues.append(newMultipleSelectionObject)
                    rows.append(StringSetting(placeholder: nil, defaultValue: nil, key: key, value: String(option), title: nil))
                }
            }
        }
        
        if let selectedOption = JunctionKeeper.sharedInstance.getValueWithKey(key) as? T {
            self.selectedOption = possibleValues.indexOf { object -> Bool in
                return (object.value as! AnyObject).isEqual(selectedOption as? AnyObject)
            }
        } else {
            if let defaultValue = self.defaultValue {
                JunctionKeeper.sharedInstance.addValueForKey(key, value: defaultValue.value as! AnyObject)
                
                selectedOption = possibleValues.indexOf({ (option) -> Bool in
                    return (option.value as! AnyObject).isEqual(defaultValue.value as? AnyObject)
                })
                
                sectionDelegate?.editsMade!()
            }
        }
    }
    
    public func registerCells(tableView: UITableView) {
        tableView.registerClass(LabelTableViewCell.self, forCellReuseIdentifier: displayCellIdentifier)
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
        if enableCustom && rows.count - 1 == row {
            return inputCellIdentifier
        } else {
            return displayCellIdentifier
        }
    }
    
    public func configureCell(cell: UITableViewCell, row: Int) {
        
        if cell.reuseIdentifier == inputCellIdentifier {
            delegateProxy = UITextFieldDelegateProxy { [weak self] (textField) in
                textField.resignFirstResponder()
                
                guard let text = textField.text where text != "" else {
                    return false
                }
                
                textField.text = nil
                
                self?.addCustomValue(text)
                self?.sectionDelegate?.editsMade!()
                
                return false
            }
            
            let inputCell = cell as! InputTableViewCell
            inputCell.textField.delegate = delegateProxy
            inputCell.textField.placeholder = placeholder
        } else if cell.reuseIdentifier == displayCellIdentifier {
            let cell = cell as! LabelTableViewCell
            
            cell.label.text = String(possibleValues[row].value)
            
            if isMultiSelect {
                if let selectedItems = JunctionKeeper.sharedInstance.getValueWithKey(key.multiSelect) as? [T] {
                    var indexes = [Int]()
                    
                    for selectedItem in selectedItems {
                        let index = possibleValues.indexOf { object -> Bool in
                            return (object.value as! AnyObject).isEqual(selectedItem as? AnyObject)
                        }
                        
                        if let index = index {
                            indexes.append(index)
                        }
                    }
                    
                    
                    if indexes.contains(row) {
                        cell.accessoryType = .Checkmark
                    } else {
                        cell.accessoryType = .None
                    }
                } else {
                    cell.accessoryType = .None
                }
            } else {
                if let selectedItem = JunctionKeeper.sharedInstance.getValueWithKey(key) as? T {
                    let index = possibleValues.indexOf { object -> Bool in
                        return (object.value as! AnyObject).isEqual(selectedItem as? AnyObject)
                    }
                    
                    if let index = index {
                        if row == index {
                            cell.accessoryType = .Checkmark
                        } else {
                            cell.accessoryType = .None
                        }
                    }
                } else {
                    cell.accessoryType = .None
                }
            }
        }
    }
    
    public func store() {
        
        guard let index = selectedOption else {
            return
        }
        
        let selected = possibleValues[index].value
        
        JunctionKeeper.sharedInstance.addValueForKey(key, value: selected as! AnyObject)
    }
    
    private func storeMultiple(add: T) {
        
    }
    
    public func didSelectCell(tableViewCell: UITableViewCell, tableView: UITableView, indexPath: NSIndexPath) {
        rows[indexPath.row].didSelectCell(tableViewCell, tableView: tableView, indexPath: indexPath)
        
        if tableViewCellIdentifier(indexPath.row) == displayCellIdentifier {
            if isMultiSelect {
                
                if let selectedNames = JunctionKeeper.sharedInstance.getValueWithKey(key.multiSelect) as? [T] {
                    let currentlySelectedOption = possibleValues[indexPath.row].value
                    
                    let contains = selectedNames.contains({ (item) -> Bool in
                        return (item as! AnyObject).isEqual(currentlySelectedOption as? AnyObject)
                    })
                    
                    if contains {
                        JunctionKeeper.sharedInstance.deleteValueFromArray(key.multiSelect, valueToDelete: possibleValues[indexPath.row].value as! AnyObject)
                    } else {
                        selectedOptions.append(indexPath.row)
                        JunctionKeeper.sharedInstance.addValueToArray(key.multiSelect, value: possibleValues[indexPath.row].value as! AnyObject)
                    }
                } else {
                    //the plist file was empty, we can safely insert because there's no risk of duplicating a current record
                    selectedOptions.append(indexPath.row)
                    JunctionKeeper.sharedInstance.addValueToArray(key.multiSelect, value: possibleValues[indexPath.row].value as! AnyObject)

                }
            } else {
                selectedOption = indexPath.row
                store()
            }
            
            configureCell(tableViewCell, row: indexPath.row)
            tableView.reloadData()
        }
    }
    
    internal func addCustomValue(value: String) {
        fatalError("addCustomValue must be overriden by subclasses")
    }
    
    public func canSwipeToDelete() -> Bool {
        return true
    }
    
    public func canSwipeToDelete(row: Int) -> Bool {
        if row >= originalValues.count {
            return true
        } else {
            return false
        }
    }
    
    public func didDeleteRow(row: Int) {
        if let selectedOption = selectedOption {
            let previousSelectedValue = possibleValues[selectedOption].value
            
            JunctionKeeper.sharedInstance.deleteValueFromArray(key.customOption, valueToDelete: possibleValues[row].value as! AnyObject)
            possibleValues.removeAtIndex(row)
            rows.removeAtIndex(row)
            
            self.selectedOption = possibleValues.indexOf({ (option) -> Bool in
                return (option.value as! AnyObject).isEqual(previousSelectedValue as? AnyObject)
            })
            
            sectionDelegate?.editsMade!()
        }
    }
}

private class UITextFieldDelegateProxy: NSObject, UITextFieldDelegate {
    typealias returnActionType = UITextField -> Bool
    
    let returnAction: returnActionType
    
    init(returnAction: returnActionType) {
        self.returnAction = returnAction
    }
    
    @objc func textFieldShouldReturn(textField: UITextField) -> Bool {
        return returnAction(textField)
    }
}
