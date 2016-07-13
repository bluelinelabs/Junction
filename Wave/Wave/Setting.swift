//
//  Setting.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/27/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation
import UIKit

public class Setting: SettingType, RowType {
    
    public var cellIdentifier: String = "waveCell"
    public var title: String?
    
    public func registerCells(tableView: UITableView) {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    public func configureCell(tableViewCell: UITableViewCell) {
        tableViewCell.textLabel?.text = title
    }

    public func didSelectCell(tableViewCell: UITableViewCell, tableView: UITableView, indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    public func store() {
        
    }
}
