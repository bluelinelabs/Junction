//
//  Setting.swift
//  Junction
//
//  Created by Jimmy McDermott on 6/27/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation
import UIKit

public class Setting: SettingType, RowType {
    
    public var cellIdentifier: String = "junctionCell"
    public var title: String?
    
    public func registerCells(tableView: UITableView) {
        tableView.registerClass(LabelTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    public func configureCell(tableViewCell: UITableViewCell) {
        if let cell = tableViewCell as? LabelTableViewCell {
            cell.label.text = title
        }
    }

    public func didSelectCell(tableViewCell: UITableViewCell, tableView: UITableView, indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    public func store() {
        fatalError("Override in subclass")
    }
    
    public func canSwipeToDelete() -> Bool {
        fatalError("Override in subclass")
    }
    
    public func didDeleteRow(row: Int) {
        fatalError("Override in subclass")
    }
}
