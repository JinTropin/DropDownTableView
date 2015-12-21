//
//  TableViewController.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 04.11.15.
//  Copyright © 2015 NSSimpleApps. All rights reserved.
//

import UIKit

class TableViewController: DropDownTableViewController {
    
    let subTitles = ["Capital", "Square", "Independence Day"]
    
    let data = [["Russia", "Moscow", "17 098 242"],
                ["USA", "Washington, D.C.", "9 857 306", "July 4"],
                ["Zimbabwe", "Harare"]]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfRowsInTableView(tableView: UITableView) -> Int {
        
        return self.data.count
    }
    
    override func tableView(tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int {
        
        return self.data[row].count - 1
    }
    
    override func tableView(tableView: UITableView, cellForRow row: Int, indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("RowCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.data[row].first
        
        return cell
    }
    
    override func tableView(tableView: UITableView, cellForSubrow subrow: Int, row: Int, indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SubrowCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.subTitles[subrow]
        cell.detailTextLabel?.text = self.data[row][subrow + 1]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, accessoryViewForSelectedRow row: Int) -> UIView? {
        
        return UIImageView(image: UIImage(named: "selectedImage"))
    }
    
    override func tableView(tableView: UITableView, accessoryViewForDeselectedRow row: Int) -> UIView? {
                
        return UIImageView(image: UIImage(named: "deselectedImage"))
    }
    
    override func tableView(tableView: UITableView, indentationLevelForRow row: Int) -> Int {
        
        return 0
    }
    
    override func tableView(tableView: UITableView, indentationLevelForSubrow subrow: Int, row: Int) -> Int {
        
        return 3
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRow row: Int) {
        
        print(cell.textLabel?.text)
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forSubrow subrow: Int, row: Int) {
        
        print(cell.textLabel?.text, cell.detailTextLabel?.text)
    }
}
