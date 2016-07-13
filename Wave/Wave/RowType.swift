//
//  RowType.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/27/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation
import UIKit

public protocol RowType {
    var cellIdentifier: String { get set }
    
    func registerCells(tableView: UITableView)
    func configureCell(tableViewCell: UITableViewCell)
    func didSelectCell(tableViewCell: UITableViewCell, tableView: UITableView, indexPath: NSIndexPath)
}
