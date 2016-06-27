//
//  RowType.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/27/16.
//  Copyright © 2016 Blue Line Labs. All rights reserved.
//

import Foundation

protocol RowType {
    associatedtype T
    
    var value: T { get set }
    var cellIdentifier: String { get set }
    
    func registerCells()
    func configureCell()
}
