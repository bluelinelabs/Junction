//
//  Setting.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/27/16.
//  Copyright © 2016 Blue Line Labs. All rights reserved.
//

import Foundation

public class Setting<U>: SettingType, RowType {
    typealias T = U
    
    var defaultValue: Setting.T? = nil
    var key: String = ""
    
    var value: Setting.T? = nil
    var cellIdentifier: String = ""
    
    func registerCells(tableView: UITableView) {
        
    }
    
    func configureCell(tableViewCell: UITableViewCell) {
        
    }
}
