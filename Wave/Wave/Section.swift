//
//  Section.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/27/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public final class Section: SectionType {
    public var name: String = ""
    var settings = [Setting]()
    public var sectionDelegate: WaveDelegate?
    
    public init(name: String) {
        self.name = name
    }
    
    public func store() {
        for setting in settings {
            setting.store()
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
        return settings.count
    }
    
    public func tableViewCellIdentifier(row: Int) -> String {
        return settings[row].cellIdentifier
    }
    
    public func addRow(setting: Setting) -> Section {
        settings.append(setting)
        return self
    }
 
    public func configureCell(cell: UITableViewCell, row: Int) {
        settings[row].configureCell(cell)
    }
    
    public func addSetting(text: String, key: String) {
        settings.append(StringSetting(placeholder: nil, defaultValue: nil, key: key, value: text, title: nil))
    }
    
    public func didSelectCell(tableViewCell: UITableViewCell, tableView: UITableView, indexPath: NSIndexPath) {
        settings[indexPath.row].didSelectCell(tableViewCell, tableView: tableView, indexPath: indexPath)
    }
}
