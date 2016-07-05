//
//  SettingType.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/27/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

protocol SettingType {
    associatedtype T
    
    var defaultValue: T? { get set }
    var key: String { get set }
}