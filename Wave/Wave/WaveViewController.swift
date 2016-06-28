//
//  WaveViewController.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/24/16.
//  Copyright © 2016 Blue Line Labs. All rights reserved.
//

import UIKit

final public class WaveViewController: UIViewController {
    //The controller that will manage the actual sidebar
    
    var sections: [SectionType]
    var frame: CGRect
    
    private var tableView: UITableView!
    
    public init(frame: CGRect, sections: [SectionType]) {
        self.sections = sections
        self.frame = frame
        
        super.init(nibName: nil, bundle: nil)
        
        self.commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        tableView = UITableView(frame: self.frame, style: .Grouped)
        
        for section in sections {
            
        }
    }
}
