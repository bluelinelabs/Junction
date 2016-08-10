//
//  SettingType.swift
//  Junction
//
//  Created by Jimmy McDermott on 6/27/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public protocol SettingType {
    func store()
    func canSwipeToDelete() -> Bool
    func didDeleteRow(row: Int)
}
