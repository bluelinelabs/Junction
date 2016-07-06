//
//  SectionType.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/27/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public protocol SectionType {
    var name: String { get set }
    
    func registerCells(tableView: UITableView)
    func numberOfRows() -> Int
    func tableViewCellIdentifier(indexPath: NSIndexPath) -> String
    func configureCell(cell: UITableViewCell, row: Int)
}
