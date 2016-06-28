//
//  Section.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/27/16.
//  Copyright © 2016 Blue Line Labs. All rights reserved.
//

import Foundation

public class Section: SectionType {
    public var name: String = ""
    var settings = [Setting<Any>]()
    
    public func registerCells(tableView: UITableView) {
        for setting in settings {
            setting.registerCells(tableView)
        }
    }
    
    public func numberOfRows() -> Int {
        return settings.count
    }
    
    public func tableViewCellIdentifier(indexPath: NSIndexPath) -> String {
        return settings[indexPath.row].cellIdentifier
    }
}
