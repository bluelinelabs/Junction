//
//  Section.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/27/16.
//  Copyright © 2016 Blue Line Labs. All rights reserved.
//

import Foundation

class Section: SectionType {
    var name: String = ""
    var settings = [Setting<Any>]()
    
    func registerCells(tableView: UITableView) {
        for setting in settings {
            setting.registerCells(tableView)
        }
    }
}
