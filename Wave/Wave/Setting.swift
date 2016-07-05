//
//  Setting.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/27/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public class Setting<U>: SettingType, RowType {
    public typealias T = U
    
    var defaultValue: Setting.T? = nil
    var key: String = ""
    
    public var value: Setting.T? = nil
    public var cellIdentifier: String = "cell"
    
    public func registerCells(tableView: UITableView) {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    public func configureCell(tableViewCell: UITableViewCell) {
        
    }
}
