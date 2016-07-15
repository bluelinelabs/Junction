//
//  JunctionViewController.swift
//  Junction
//
//  Created by Jimmy McDermott on 6/24/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import UIKit

final internal class JunctionViewController: UIViewController {
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
    
    func dismiss() {
        
        for section in sections {
            section.store()
        }
        
        Junction.completionBlock?(previousValues: [""], newValues: [""])
        
        dismissViewControllerAnimated(true, completion: nil)
    }
        
    override internal func loadView() {
        super.loadView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(dismiss))
        title = NSLocalizedString("Junction", comment: "Junction Nav Bar Title")
        
        view.addSubview(tableView)
    }

    internal init(frame: CGRect, sections: [SectionType]) {
        self.sections = sections
        self.frame = frame
        
        super.init(nibName: nil, bundle: nil)
        
        for var section in sections {
            section.sectionDelegate = self
        }
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JunctionViewController: UITableViewDelegate {
    internal func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = sections[indexPath.section]
        let cellIdentifier = sections[indexPath.section].tableViewCellIdentifier(indexPath.row)
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        section.didSelectCell(cell!, tableView: tableView, indexPath: indexPath)
    }
}

extension JunctionViewController: UITableViewDataSource {
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows()
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        section.registerCells(tableView)
        
        let cellIdentifier = sections[indexPath.section].tableViewCellIdentifier(indexPath.row)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        section.configureCell(cell, row: indexPath.row)
        
        return cell
    }
    
    internal func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
}

extension JunctionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension JunctionViewController: SectionModifiedDelegate {
    func editsMade() {
        tableView.reloadData()
    }
}
