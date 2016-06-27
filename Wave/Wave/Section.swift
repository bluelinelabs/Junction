//
//  Section.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/27/16.
//  Copyright © 2016 Blue Line Labs. All rights reserved.
//

import Foundation

protocol Section: SectionType {
    associatedtype T = Setting
    var settings: [T] { get set }
}