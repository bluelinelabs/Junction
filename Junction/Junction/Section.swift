//
//  Section.swift
//  Junction
//
//  Created by Jimmy McDermott on 6/27/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation
import UIKit

public final class Section: SectionType {
    public var name: String = ""
    var settings = [Setting]()
    public var sectionDelegate: SectionModifiedDelegate?
    
    public convenience init(name: String) {
        self.init(name: name, settings: [Setting]())
    }
    
    public init(name: String, settings: [Setting]) {
        self.name = name
        self.settings = settings
    }
    
    public func store() {
        for setting in settings {
            setting.store()
        }
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
    
    public func didSelectCell(tableViewCell: UITableViewCell, tableView: UITableView, indexPath: NSIndexPath) {
        settings[indexPath.row].didSelectCell(tableViewCell, tableView: tableView, indexPath: indexPath)
    }
}
