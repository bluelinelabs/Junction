//
//  SectionType.swift
//  Junction
//
//  Created by Jimmy McDermott on 6/27/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation
import UIKit

public protocol SectionType {
    var name: String { get set }
    var sectionDelegate: SectionModifiedDelegate? { get set }
    
    func registerCells(tableView: UITableView)
    func numberOfRows() -> Int
    func tableViewCellIdentifier(row: Int) -> String
    func configureCell(cell: UITableViewCell, row: Int)
    func didSelectCell(tableViewCell: UITableViewCell, tableView: UITableView, indexPath: NSIndexPath)
    func canSwipeToDelete(row: Int) -> Bool
    func didDeleteRow(row: Int)
    func store()
}
