//
//  DropDownTableViewController.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 25.03.15.
//  Copyright (c) 2015 NSSimpleApps. All rights reserved.
//

import UIKit

extension NSIndexSet {
    
    func minusIndexSet(indexSet : NSIndexSet) -> NSIndexSet {
        
        let result = NSMutableIndexSet()
        self.enumerateIndexesUsingBlock { (index, stop) -> Void in
            
            if !indexSet.containsIndex(index) {
                
                result.addIndex(index)
            }
        }
        return result
    }
}

extension NSDictionary {
    
    func keyAtIndex(index : Int) -> String? {
        
        if index >= 0 && index < self.count {
            
            return self.allKeys[index] as? String
        }
        return nil
    }
    
    func valueAtIndex(index : Int) -> NSDictionary? {
        
        if let key = self.keyAtIndex(index) {
            
            return self.objectForKey(key) as? NSDictionary
        }
        return nil
    }
    
    func stringValueAtIndex(index : Int) -> String? {
        
        if let key = self.keyAtIndex(index) {
            
            return self.objectForKey(key) as? String
        }
        return nil
    }
    
    func lengthOfValue(index : Int) -> Int {
        
        if let value = self.valueAtIndex(index) {
            
            return value.count
        }
        return 0
    }
}

class DropDownTableViewController: UITableViewController {

    var selectedIndexPath : NSIndexPath? = nil
    
    let data : NSDictionary = ["Russia" : ["capital" : "Moscow", "square" : "17 098 242"],
        "USA" : ["capital" : "Washington, D.C.", "Independence Day" : "July 4", "square" : "9 857 306"],
        "Zimbabwe" : ["capital" : "Harare"]]

    var numberOfRows : Int = 0
    
    var indexSetForMainCells : NSIndexSet {
        
        if let selectedRow = self.selectedIndexPath?.row {
            
            let indexSet = NSMutableIndexSet(indexesInRange: NSMakeRange(0, selectedRow + 1))
            
            let offset = self.data.lengthOfValue(selectedRow)
            
            for var index = selectedRow + offset + 1; index < self.numberOfRows; index++ {
                
                indexSet.addIndex(index)
            }
            
            return indexSet
            
        } else {
            
            return NSIndexSet(indexesInRange: NSMakeRange(0, self.numberOfRows))
        }
    }
    
    var indexSetForDetailedCells : NSIndexSet? {
        
        if self.selectedIndexPath == nil {
            
            return nil
        }
        return NSIndexSet(indexesInRange: NSMakeRange(0, self.numberOfRows)).minusIndexSet(self.indexSetForMainCells)
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.numberOfRows = self.data.count
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.numberOfRows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let indexSetForMainCells = self.indexSetForMainCells
        
        if indexSetForMainCells.containsIndex(indexPath.row) {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.accessoryView = UIImageView(image: UIImage(named: "down_disclosure_indicator"))
            
            if let label = self.data.keyAtIndex(indexPath.row) {
                
                cell.textLabel?.text = label
            }
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailedCell", forIndexPath: indexPath) as UITableViewCell
            if let firstIndex = self.indexSetForDetailedCells?.firstIndex {
                
                let dict = self.data.valueAtIndex(firstIndex - 1)
                cell.textLabel?.text = dict?.keyAtIndex(indexPath.row - firstIndex)
                cell.detailTextLabel?.text = dict?.stringValueAtIndex(indexPath.row - firstIndex)
            }
            return cell
        }
    }
    
    func hideTableViewCells(didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let highlightedCell = tableView.cellForRowAtIndexPath(indexPath)
        highlightedCell?.accessoryView = UIImageView(image: UIImage(named: "down_disclosure_indicator"))
        
        let length = self.data.lengthOfValue(indexPath.row)
        
        self.numberOfRows -= length
        
        self.tableView.beginUpdates()
        for var row = indexPath.row + length; row > indexPath.row; row-- {
            
            self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forItem: row, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        self.tableView.endUpdates()
    }
    
    func showTableViewCells(didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let highlightedCell = tableView.cellForRowAtIndexPath(indexPath)
        highlightedCell?.accessoryView = UIImageView(image: UIImage(named: "up_disclosure_indicator"))
        
        let selectedRow = indexPath.row
        let length = self.data.lengthOfValue(indexPath.row)
        
        self.numberOfRows += length
        
        self.tableView.beginUpdates()
        for var row = selectedRow + 1; row <= selectedRow + length; row++ {
            
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forItem: row, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        self.tableView.endUpdates()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if self.indexSetForMainCells.containsIndex(indexPath.row) {
            
            if self.selectedIndexPath == nil {
                
                self.selectedIndexPath = indexPath
                self.showTableViewCells(didSelectRowAtIndexPath: indexPath)
            } else if self.selectedIndexPath == indexPath {
                
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                self.selectedIndexPath = nil
                self.hideTableViewCells(didSelectRowAtIndexPath: indexPath)
            } else {
                
                self.hideTableViewCells(didSelectRowAtIndexPath: self.selectedIndexPath!)
                self.selectedIndexPath = tableView.indexPathForSelectedRow()
                self.showTableViewCells(didSelectRowAtIndexPath: self.selectedIndexPath!)
            }
        }
    }
}
