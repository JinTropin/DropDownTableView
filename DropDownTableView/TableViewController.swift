//
//  TableViewController.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 04.11.15.
//  Copyright © 2015 NSSimpleApps. All rights reserved.
//

import UIKit

class Pair: NSObject {
    
    var key = ""
    var value = ""
    
    init(key: String, value: String) {
        
        self.key = key
        self.value = value
    }
}

class State: NSObject {
    
    var name = ""
    
    var parameters = NSMutableOrderedSet()
}

class TableViewController: DropDownTableViewController {
    
    var data: [State] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let russia = State()
        russia.name = "Russia"
        russia.parameters.addObject(Pair(key: "Capital", value: "Moscow"))
        russia.parameters.addObject(Pair(key: "Square", value: "17 098 242"))
        
        let usa = State()
        usa.name = "USA"
        usa.parameters.addObject(Pair(key: "Capital", value: "Washington, D.C."))
        usa.parameters.addObject(Pair(key: "Square", value: "9 857 306"))
        usa.parameters.addObject(Pair(key: "Independence Day", value: "July 4"))
        
        let zimbabwe = State()
        zimbabwe.name = "Zimbabwe"
        zimbabwe.parameters.addObject(Pair(key: "Capital", value: "Harare"))
        
        self.data = [russia, usa, zimbabwe]
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfRowsInTableView(tableView: UITableView) -> Int {
        
        return self.data.count
    }
    
    override func tableView(tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int {
        
        return self.data[row].parameters.count
    }
    
    override func tableView(tableView: UITableView, cellForRow row: Int, indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("RowCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.data[row].name
        
        return cell
    }
    
    override func tableView(tableView: UITableView, cellForSubrow subrow: Int, inRow row: Int, indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SubrowCell", forIndexPath: indexPath)
        
        let parameters = self.data[row].parameters.objectAtIndex(subrow) as! Pair
        
        cell.textLabel?.text = parameters.key
        cell.detailTextLabel?.text = parameters.value
        
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
    
    override func tableView(tableView: UITableView, indentationLevelForSubrow subrow: Int, inRow: Int) -> Int {
        
        return 3
    }
    
    override func tableView(tableView: UITableView, canEditRow row: Int) -> Bool {
        
        return true
    }
    
    override func tableView(tableView: UITableView, canEditSubrow subrow: Int, inRow row: Int) -> Bool {
        
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRow row: Int) {
        
        if editingStyle == .Delete {
            
            self.data.removeAtIndex(row)
            
            tableView.deleteRowsAtRows([row], withRowAnimation: .Automatic)
            
        } else if editingStyle == .Insert {
            
            
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forSubrow subrow: Int, inRow row: Int) {
        
        if editingStyle == .Delete {
            
            self.data[row].parameters.removeObjectAtIndex(subrow)
            
            tableView.deleteSubrows([subrow], inRow: row, withRowAnimation: .Automatic)
            
        } else if editingStyle == .Insert {
            
            let alertController = UIAlertController(title: "Insert new subrow", placeholders: ["parameter", "value"], completion: { (texts: [String?]) -> Void in
                
                let key = texts.first! ?? "??"
                let value = texts.last! ?? "??"
                
                self.data[row].parameters.insertObject(Pair(key: key, value: value), atIndex: 0)
                
                tableView.insertSubrows([0], inRow: row, withRowAnimation: .Automatic)
            })
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    override func tableView(tableView: UITableView, editingStyleForRow row: Int) -> UITableViewCellEditingStyle {
        
        return .Delete
    }
    
    override func tableView(tableView: UITableView, editingStyleForSubrow subrow: Int, inRow row: Int) -> UITableViewCellEditingStyle {
        
        return .Delete
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRow row: Int) {
        
        print(cell.textLabel?.text, row)
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forSubrow subrow: Int, inRow row: Int) {
        
        print(cell.detailTextLabel?.text, row, subrow)
    }
    
    override func tableView(tableView: UITableView, canMoveRow row: Int) -> Bool {
        
        return true
    }
    
    override func tableView(tableView: UITableView, canMoveSubrow subrow: Int, inRow row: Int) -> Bool {
        
        return true
    }
    
    override func tableView(tableView: UITableView, targetRowForMoveFromRow sourceRow: Int, toProposedRow proposedDestinationRow: Int) -> Int {
        
        return proposedDestinationRow
    }
    
    override func tableView(tableView: UITableView, targetSubrowForMoveFromSubrow sourceSubrow: Int, toProposedSubrow proposedDestinationSubrow: Int, inRow row: Int) -> Int {
        
        return proposedDestinationSubrow
    }
    
    override func tableView(tableView: UITableView, moveRow sourceRow: Int, toRow destinationRow: Int) {
        
        swap(&self.data[sourceRow], &self.data[destinationRow])
    }
    
    override func tableView(tableView: UITableView, moveSubrow sourceSubrow: Int, toSubrow destinationSubrow: Int, inRow row: Int) {
        
        let state = self.data[row]
        state.parameters.exchangeObjectAtIndex(sourceSubrow, withObjectAtIndex: destinationSubrow)
    }
}
