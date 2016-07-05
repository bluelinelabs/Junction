//
//  Setting.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/27/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public class Setting: SettingType, RowType {
    
    public var cellIdentifier: String = "waveCell"
    public var title: String?
    
    public func registerCells(tableView: UITableView) {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    public func configureCell(tableViewCell: UITableViewCell) {
        
    }
    
    public func store() {
        
    }
}
