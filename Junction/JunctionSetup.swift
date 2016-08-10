//
//  JunctionSetup.swift
//  Junction
//
//  Created by Jimmy McDermott on 8/10/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import Foundation

public protocol JunctionSetup {
    func sections() -> [SectionType]
    var debugMode: Bool { get set }
}
