//
//  TestViewController.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 26.12.15.
//  Copyright © 2015 NSSimpleApps. All rights reserved.
//

import UIKit

class AnotherTestController: DropDownTableViewController {
    
    private var numberOfSubrows = 5
    private var numberOfRows = 50
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Another test"
        
        self.navigationItem.rightBarButtonItem =
        
        UIBarButtonItem(barButtonSystemItem: .Done,
                        target: self,
                        action: #selector(self.deleteRow(_:)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func deleteRow(sender: UIBarButtonItem) {
        
        self.numberOfRows += 2
        
        self.tableView.insertRowsAtRows([0, 1], withRowAnimation: .Automatic)
    }
    
    override func numberOfRowsInTableView(tableView: UITableView) -> Int {
        
        return self.numberOfRows
    }
    
    override func tableView(tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int {
        
        return self.numberOfSubrows
    }
    
    override func tableView(tableView: UITableView, cellForRow row: Int, indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = "Row " + String(row)
        cell.detailTextLabel?.text = nil
        
        return cell
    }
    
    override func tableView(tableView: UITableView, cellForSubrow subrow: Int, inRow row: Int, indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = "Subrow " + String(row)
        cell.detailTextLabel?.text = String(subrow)
        cell.accessoryView = nil
        
        return cell
    }
    
    override func tableView(tableView: UITableView, accessoryViewForSelectedRow row: Int) -> UIView? {
        
        return UIImageView(image: UIImage(named: "selectedImage"))
    }
    
    override func tableView(tableView: UITableView, accessoryViewForDeselectedRow row: Int) -> UIView? {
        
        return UIImageView(image: UIImage(named: "deselectedImage"))
    }
}
