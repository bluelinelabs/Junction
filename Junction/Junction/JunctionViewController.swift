//
//  JunctionViewController.swift
//  Junction
//
//  Created by Jimmy McDermott on 6/24/16.
//  Copyright © 2016 BlueLine Labs. All rights reserved.
//

import UIKit

final internal class JunctionViewController: UITableViewController {
    //The controller that will manage the actual sidebar
    
    var sections: [SectionType]
    var previousValues: NSDictionary!
    
    func dismiss() {
        
        storeAll()
        
        if let dictionary = JunctionKeeper.sharedInstance.loadAllData() {
            Junction.settingsUpdatedBlock?(previousValues: previousValues, newValues: dictionary)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func storeAll() {
        for section in sections {
            section.store()
        }
    }
    
    internal func prepareForDisplay() {
        storeAll()
        
        if let dictionary = JunctionKeeper.sharedInstance.loadAllData() {
            previousValues = dictionary
        }
        
    }
    
    override internal func loadView() {
        super.loadView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(dismiss))
        title = NSLocalizedString("Junction", comment: "Junction Nav Bar Title")
        
        NSLayoutConstraint(item: tableView, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: tableView, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: tableView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: tableView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0).active = true
    }

    internal init(sections: [SectionType]) {
        self.sections = sections
        
        super.init(style: .Grouped)
        
        for var section in sections {
            section.sectionDelegate = self
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//UITableView Delegate
extension JunctionViewController {
    internal override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = sections[indexPath.section]
        let cellIdentifier = sections[indexPath.section].tableViewCellIdentifier(indexPath.row)
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        section.didSelectCell(cell!, tableView: tableView, indexPath: indexPath)
    }
    
    internal override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let section = sections[indexPath.section]
        return section.canSwipeToDelete(indexPath.row)
    }
    
    internal override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) in
            self.sections[indexPath.section].didDeleteRow(indexPath.row)
        }
        
        return [deleteAction]
    }
}

//UITableView DataSource
extension JunctionViewController {
    internal override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    internal override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].numberOfRows()
    }
    
    internal override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        section.registerCells(tableView)
        
        let cellIdentifier = sections[indexPath.section].tableViewCellIdentifier(indexPath.row)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        section.configureCell(cell, row: indexPath.row)
        
        return cell
    }
    
    internal override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
