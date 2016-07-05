//
//  WaveViewController.swift
//  Wave
//
//  Created by Jimmy McDermott on 6/24/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import UIKit

final public class WaveViewController: UIViewController {
    //The controller that will manage the actual sidebar
    
    var sections: [SectionType]
    var frame: CGRect
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.frame, style: .Grouped)
        tableView.autoresizingMask = [.FlexibleRightMargin, .FlexibleLeftMargin, .FlexibleBottomMargin, .FlexibleTopMargin]
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override public func loadView() {
        super.loadView()
        view.addSubview(tableView)
    }

    public init(frame: CGRect, sections: [SectionType]) {
        self.sections = sections
        self.frame = frame
        
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WaveViewController: UITableViewDelegate {
    
}

extension WaveViewController: UITableViewDataSource {
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows()
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        section.registerCells(tableView)
        
        let cellIdentifier = sections[indexPath.section].tableViewCellIdentifier(indexPath)
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        section.configureCell(cell, row: indexPath.row)
        
        return cell
    }
     
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
}
