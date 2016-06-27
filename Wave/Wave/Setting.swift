//
//  Setting.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/27/16.
//  Copyright © 2016 Blue Line Labs. All rights reserved.
//

import Foundation

protocol Setting: SettingType {
    associatedtype T
    
    var name: String? { get set }
}
