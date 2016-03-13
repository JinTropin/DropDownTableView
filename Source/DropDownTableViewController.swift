//
//  DropDownTableViewController.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 25.03.15.
//  Copyright (c) 2015 NSSimpleApps. All rights reserved.
//

import UIKit

////////////////////////////////////////////////
//
// row0 \/      -\
// row1 \/       | -> one section tableView in fact
// row2 \/      -/
//
//
//
//
// row0 /\      -\
//    subrow0     \
//    subrow1     |
//    subrow2     | -> one section tableView in fact
//    subrow3     |
// row1 \/        /
// row2 \/      -/
//
////////////////////////////////////////////////

@available(iOS 8.0, *)
@objc public protocol DropDownTableViewDataSource : NSObjectProtocol {
    
    func numberOfRowsInTableView(tableView: UITableView) -> Int // Default is 0
    
    optional func tableView(tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int // Default is 0
    
    func tableView(tableView: UITableView, cellForRow row: Int, indexPath: NSIndexPath) -> UITableViewCell // must be overriden in child class
    
    func tableView(tableView: UITableView, cellForSubrow subrow: Int, inRow row: Int, indexPath: NSIndexPath) -> UITableViewCell // must be overriden in child class
    
    optional func titleForHeaderInTableView(tableView: UITableView) -> String?  // Default is nil
    
    optional func titleForFooterInTableView(tableView: UITableView) -> String?  // Default is nil
    
    optional func tableView(tableView: UITableView, canEditRow row: Int) -> Bool // default is false
    
    optional func tableView(tableView: UITableView, canEditSubrow subrow: Int, inRow row: Int) -> Bool // default is false
    
    optional func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRow row: Int)
    
    optional func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forSubrow subrow: Int, inRow row: Int)
    
    optional func tableView(tableView: UITableView, canMoveRow row: Int) -> Bool // default is false
    
    optional func tableView(tableView: UITableView, canMoveSubrow subrow: Int, inRow row: Int) -> Bool // default is false
    
    
    optional func tableView(tableView: UITableView, accessoryViewForSelectedRow row: Int) -> UIView?  // Default is nil
    
    optional func tableView(tableView: UITableView, accessoryViewForDeselectedRow row: Int) -> UIView?  // Default is nil
    
    optional func tableView(tableView: UITableView, moveRow sourceRow: Int, toRow destinationRow: Int)
    
    optional func tableView(tableView: UITableView, moveSubrow sourceSubrow: Int, toSubrow destinationSubrow: Int, inRow row: Int)
}

@available(iOS 8.0, *)
@objc public protocol DropDownTableViewDelegate : NSObjectProtocol {
    
    optional func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRow row: Int)
    
    optional func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forSubrow subrow: Int, inRow row: Int)
    
    optional func tableView(tableView: UITableView, willDisplayHeaderView view: UIView)
    
    optional func tableView(tableView: UITableView, willDisplayFooterView view: UIView)
    
    optional func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRow row: Int)
    
    optional func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forSubrow subrow: Int, inRow row: Int)
    
    optional func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView)
    
    optional func tableView(tableView: UITableView, didEndDisplayingFooterView view: UIView)
    
    optional func tableView(tableView: UITableView, heightForRow row: Int) -> CGFloat
    
    optional func tableView(tableView: UITableView, heightForSubrow subrow: Int, inRow row: Int) -> CGFloat
    
    optional func heightForHeaderInTableView(tableView: UITableView) -> CGFloat
    
    optional func heightForFooterInTableView(tableView: UITableView) -> CGFloat
    
    optional func tableView(tableView: UITableView, estimatedHeightForRow row: Int) -> CGFloat
    
    optional func tableView(tableView: UITableView, estimatedHeightForSubrow subrow: Int, inRow row: Int) -> CGFloat
    
    optional func estimatedHeightForHeaderInTableView(tableView: UITableView) -> CGFloat
    
    optional func estimatedHeightForFooterInTableView(tableView: UITableView) -> CGFloat
    
    optional func viewForHeaderInTableView(tableView: UITableView) -> UIView?
    
    optional func viewForFooterInTableView(tableView: UITableView) -> UIView?
    
    optional func tableView(tableView: UITableView, accessoryButtonTappedForRow row: Int)
    
    optional func tableView(tableView: UITableView, accessoryButtonTappedForSubrow subrow: Int, inRow row: Int)
    
    optional func tableView(tableView: UITableView, shouldHighlightRow row: Int) -> Bool
    
    optional func tableView(tableView: UITableView, shouldHighlightSubrow subrow: Int, inRow row: Int) -> Bool
    
    optional func tableView(tableView: UITableView, didHighlightRow row: Int)
    
    optional func tableView(tableView: UITableView, didHighlightSubrow subrow: Int, inRow row: Int)
    
    optional func tableView(tableView: UITableView, didUnhighlightRow row: Int)
    
    optional func tableView(tableView: UITableView, didUnhighlightSubrow subrow: Int, inRow row: Int)
    
    optional func tableView(tableView: UITableView, didSelectRow row: Int)
    
    optional func tableView(tableView: UITableView, didDeselectRow row: Int)
    
    optional func tableView(tableView: UITableView, editingStyleForRow row: Int) -> UITableViewCellEditingStyle // default is .None
    
    optional func tableView(tableView: UITableView, editingStyleForSubrow subrow: Int, inRow row: Int) -> UITableViewCellEditingStyle // default is .None
    
    optional func tableView(tableView: UITableView, indentationLevelForRow row: Int) -> Int
    
    optional func tableView(tableView: UITableView, indentationLevelForSubrow subrow: Int, inRow row: Int) -> Int
    
    optional func tableView(tableView: UITableView, shouldIndentWhileEditingRow row: Int) -> Bool // default is false
    
    optional func tableView(tableView: UITableView, shouldIndentWhileEditingSubrow subrow: Int, inRow row: Int) -> Bool // default is false
    
    optional func tableView(tableView: UITableView, willBeginEditingRow row: Int)
    
    optional func tableView(tableView: UITableView, willBeginEditingSubrow subrow: Int, inRow row: Int)
    
    optional func tableView(tableView: UITableView, didEndEditingRow row: Int)
    
    optional func tableView(tableView: UITableView, didEndEditingSubrow subrow: Int, inRow row: Int)
    
    
    optional func tableView(tableView: UITableView, targetRowForMoveFromRow sourceRow: Int, toProposedRow proposedDestinationRow: Int) -> Int // default is sourceRow
    
    optional func tableView(tableView: UITableView, targetSubrowForMoveFromSubrow sourceSubrow: Int, toProposedSubrow proposedDestinationSubrow: Int, inRow row: Int) -> Int // default is sourceSubrow
}

@available(iOS 8.0, *)
public class DropDownTableViewController: UITableViewController, DropDownTableViewDataSource, DropDownTableViewDelegate {
    
    private var subrows: [Int] = []
    
    override public final func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    // please use this method instead of -[UITableView cellForRowAtIndexPath:]
    public func cellForRow(row: Int) -> UITableViewCell? {
        
        if row < self.subrows.first {
            
            return self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0))
            
        } else {
            
            return self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row + self.subrows.count, inSection: 0))
        }
    }
    
    // please use this method instead of -[UITableView cellForRowAtIndexPath:]
    public func cellForSubrow(subrow: Int, inRow row: Int) -> UITableViewCell? {
        
        guard subrow >= 0 && subrow <= (self.subrows.count - 1) else {
            
            return nil
        }
        
        if row + 1 == self.subrows.first {
            
            return self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row + subrow + 1, inSection: 0))
        }
        return nil
    }
    
    // please use this method instead of -[UITableView deleteRowsAtIndexPaths:withRowAnimation:]
    public func deleteRowAtRow(row: Int, withRowAnimation animation: UITableViewRowAnimation) {
        
        var rowToDelete = 0
        
        if row < self.subrows.first {
            
            rowToDelete = row
            
        } else {
            
            rowToDelete = row + self.subrows.count
        }
        
        self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: rowToDelete, inSection: 0)], withRowAnimation: animation)
    }
    
    // please use this method instead of -[UITableView deleteRowsAtIndexPaths:withRowAnimation:]
    public func deleteSubrowAtSubrow(subrow: Int, inRow row: Int, withRowAnimation animation: UITableViewRowAnimation) {
        
        guard subrow >= 0 && subrow <= (self.subrows.count - 1) else {
            
            return
        }
        self.subrows.removeLast()
        
        self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: row + subrow + 1, inSection: 0)], withRowAnimation: animation)
    }
    
    // please use this method instead of -[UITableView insertRowsAtIndexPaths:withRowAnimation:]
    public func insertRowAtRow(row: Int, withRowAnimation animation: UITableViewRowAnimation) {
        
        if row < self.subrows.first {
            
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: row, inSection: 0)], withRowAnimation: animation)
            
        } else {
            
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: row + self.subrows.count, inSection: 0)], withRowAnimation: animation)
        }
    }
    
    // please use this method instead of -[UITableView insertRowsAtIndexPaths:withRowAnimation:]
    public func insertSubrowAtSubrow(subrow: Int, inRow row: Int, withRowAnimation animation: UITableViewRowAnimation) {
        
        guard subrow >= 0 && subrow <= self.subrows.count else {
            
            return
        }
            
        self.subrows.extend(row + subrow + 1)
        
        self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: row + subrow + 1, inSection: 0)], withRowAnimation: animation)
    }
    
    // DropDownTableViewDataSource implementation
    
    // ****************
    public func numberOfRowsInTableView(tableView: UITableView) -> Int {
        
        return 0
    }
    
    override public final func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.numberOfRowsInTableView(tableView) + self.subrows.count
    }
    
    // ****************
    public func tableView(tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int {
        
        return 0
    }
    
    // ****************
    public func tableView(tableView: UITableView, cellForRow row: Int, indexPath: NSIndexPath) -> UITableViewCell {
        
        fatalError(__FUNCTION__ + " has not been implemented")
    }
    
    public func tableView(tableView: UITableView, cellForSubrow subrow: Int, inRow row: Int, indexPath: NSIndexPath) -> UITableViewCell {
        
        fatalError(__FUNCTION__ + " has not been implemented")
    }
    
    public func tableView(tableView: UITableView, accessoryViewForSelectedRow row: Int) -> UIView? {
        
        return nil
    }
    
    public func tableView(tableView: UITableView, accessoryViewForDeselectedRow row: Int) -> UIView? {
        
        return nil
    }
    
    override public final func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> UITableViewCell in
                
                let cellForRow = self.tableView(tableView, cellForRow: row, indexPath: indexPath)
                
                let accessoryViewForSelectedRow = self.tableView(tableView, accessoryViewForSelectedRow: row)
                
                let accessoryViewForDeselectedRow = self.tableView(tableView, accessoryViewForDeselectedRow: row)
                
                if row + 1 == self.subrows.first {
                    
                    if accessoryViewForSelectedRow != nil {
                        
                        cellForRow.accessoryView = accessoryViewForSelectedRow
                    }
                    
                } else if accessoryViewForDeselectedRow != nil {
                    
                    cellForRow.accessoryView = accessoryViewForDeselectedRow
                }
                
                return cellForRow
                
            }) { (subrow, row) -> UITableViewCell in
                
                let cellForSubrow = self.tableView(tableView, cellForSubrow: subrow, inRow: row, indexPath: indexPath)
                
                return cellForSubrow
        }
    }
    
    // ****************
    public func titleForHeaderInTableView(tableView: UITableView) -> String? {
        
        return super.tableView(tableView, titleForHeaderInSection: 0)
    }
    
    override public final func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.titleForHeaderInTableView(tableView)
    }
    
    // ****************
    public func titleForFooterInTableView(tableView: UITableView) -> String? {
        
        return super.tableView(tableView, titleForFooterInSection: 0)
    }
    
    override public final func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return self.titleForFooterInTableView(tableView)
    }
    
    
    // ****************
    public func tableView(tableView: UITableView, canEditRow row: Int) -> Bool {
        
        return false
    }
    
    public func tableView(tableView: UITableView, canEditSubrow subrow: Int, inRow row: Int) -> Bool {
        
        return false
    }
    
    override public final func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Bool in
                
                return self.subrows.isEmpty && self.tableView(tableView, canEditRow: row)
            },
            functionForSubrow: { (subrow, row) -> Bool in
                
                return self.tableView(tableView, canEditSubrow: subrow, inRow: row)
        })
    }
    
    // ****************
    
    public func tableView(tableView: UITableView, canMoveRow row: Int) -> Bool {
        
        return false
    }
    
    public func tableView(tableView: UITableView, canMoveSubrow subrow: Int, inRow row: Int) -> Bool {
        
        return false
    }
    
    
    override public final func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Bool in
                
                return self.subrows.isEmpty && self.tableView(tableView, canMoveRow: row)
            },
            functionForSubrow: { (subrow, row) -> Bool in
                
                return self.tableView(tableView, canMoveSubrow: subrow, inRow: row)
        })
    }
    
    // ****************
    /*override public func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        
        return nil
    }
    
    override public func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        
        return 0
    }*/
    
    // ****************
    public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRow row: Int) {
        
        
    }
    
    public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forSubrow subrow: Int, inRow row: Int) {
        
        
    }
    
    override public final func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Void in
                
                self.tableView(tableView, commitEditingStyle: editingStyle, forRow: row)
                
            }) { (subrow, row) -> Void in
                
                self.tableView(tableView, commitEditingStyle: editingStyle, forSubrow: subrow, inRow: row)
        }
    }
    
    // ****************
    public func tableView(tableView: UITableView, moveRow sourceRow: Int, toRow destinationRow: Int) {
        
    }
    
    public func tableView(tableView: UITableView, moveSubrow sourceSubrow: Int, toSubrow destinationSubrow: Int, inRow row: Int) {
        
    }
    
    override public final func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        if self.subrows.isEmpty {
            
            let sourceRow = sourceIndexPath.row
            let destinationRow = destinationIndexPath.row
            
            self.tableView(tableView, moveRow: sourceRow, toRow: destinationRow)
            
        } else {
            
            let row = self.subrows.first! - 1
            let sourceSubrow = sourceIndexPath.row - row - 1
            let destinationSubrow = destinationIndexPath.row - row - 1
            
            self.tableView(tableView, moveSubrow: sourceSubrow, toSubrow: destinationSubrow, inRow: row)
        }
    }
    
    // DropDownTableViewDelegate implementation
    
    // ****************
    public func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRow row: Int) {
        
    }
    
    // ****************
    public func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forSubrow subrow: Int, inRow row: Int) {
        
    }
    
    override public final func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Void in
                
                self.tableView(tableView, willDisplayCell: cell, forRow: row)
                
            }) { (subrow, row) -> Void in
                
                self.tableView(tableView, willDisplayCell: cell, forSubrow: subrow, inRow: row)
        }
    }
    
    // ****************
    public func tableView(tableView: UITableView, willDisplayHeaderView view: UIView) {
        
    }
    
    override public final func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        self.tableView(tableView, willDisplayHeaderView: view)
    }
    
    // ****************
    public func tableView(tableView: UITableView, willDisplayFooterView view: UIView) {
        
    }
    
    override public final func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        self.tableView(tableView, willDisplayFooterView: view)
    }
    
    // ****************
    public func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRow row: Int) {
        
    }
    
    public func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forSubrow subrow: Int, inRow row: Int) {
        
    }
    
    override public func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    // ****************
    public func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView) {
        
    }
    
    override public final func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        
        self.tableView(tableView, didEndDisplayingHeaderView: view)
    }
    
    // ****************
    public func tableView(tableView: UITableView, didEndDisplayingFooterView view: UIView) {
        
    }
    
    override public final func tableView(tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        
        self.tableView(tableView, didEndDisplayingFooterView: view)
    }
    
    // ****************
    public func tableView(tableView: UITableView, heightForRow row: Int) -> CGFloat {
        
        if row < self.subrows.first {
            
            return super.tableView(tableView, heightForRowAtIndexPath: NSIndexPath(forRow: row, inSection: 0))
        } else {
            
            return super.tableView(tableView, heightForRowAtIndexPath: NSIndexPath(forRow: row + self.subrows.count, inSection: 0))
        }
    }
    
    public func tableView(tableView: UITableView, heightForSubrow subrow: Int, inRow row: Int) -> CGFloat {
        
        return super.tableView(tableView, heightForRowAtIndexPath: NSIndexPath(forRow: row + subrow + 1, inSection: 0))
    }
    
    override public final func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> CGFloat in
                
                return self.tableView(tableView, heightForRow: row)
                
            },
            functionForSubrow: { (subrow, row) -> CGFloat in
                
                return self.tableView(tableView, heightForSubrow: subrow, inRow: row)
        })
    }
    
    // ****************
    public func heightForHeaderInTableView(tableView: UITableView) -> CGFloat {
        
        return super.tableView(tableView, heightForHeaderInSection: 0)
    }
    
    override public final func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return self.heightForHeaderInTableView(tableView)
    }
    
    // ****************
    public func heightForFooterInTableView(tableView: UITableView) -> CGFloat {
        
        return super.tableView(tableView, heightForFooterInSection: 0)
    }
    
    override public final func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return self.heightForFooterInTableView(tableView)
    }
    
    // ****************
    public func tableView(tableView: UITableView, estimatedHeightForRow row: Int) -> CGFloat {
        
        return tableView.rowHeight //tableView.estimatedRowHeight
    }
    
    public func tableView(tableView: UITableView, estimatedHeightForSubrow subrow: Int, inRow row: Int) -> CGFloat {
        
        return tableView.rowHeight //tableView.estimatedRowHeight
    }
    
    override public final func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> CGFloat in
                
                return self.tableView(tableView, estimatedHeightForRow: row)
            },
            functionForSubrow: { (subrow, row) -> CGFloat in
                
                return self.tableView(tableView, estimatedHeightForSubrow: row - self.subrows.first!, inRow: self.subrows.first! - 1)
        })
    }
    
    // ****************
    public func estimatedHeightForHeaderInTableView(tableView: UITableView) -> CGFloat {
        
        return tableView.estimatedSectionHeaderHeight
    }
    
    override public final func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        
        return self.estimatedHeightForHeaderInTableView(tableView)
    }
    
    public func estimatedHeightForFooterInTableView(tableView: UITableView) -> CGFloat {
        
        return tableView.estimatedSectionFooterHeight
    }
    
    override public final func tableView(tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        
        return self.estimatedHeightForFooterInTableView(tableView)
    }
    
    // ****************
    public func viewForHeaderInTableView(tableView: UITableView) -> UIView? {
        
        return super.tableView(tableView, viewForHeaderInSection: 0)
    }
    
    override public final func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return self.viewForHeaderInTableView(tableView)
    }
    
    // ****************
    public func viewForFooterInTableView(tableView: UITableView) -> UIView? {
        
        return super.tableView(tableView, viewForFooterInSection: 0)
    }
    
    override public final func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return self.viewForFooterInTableView(tableView)
    }
    
    // ****************
    public func tableView(tableView: UITableView, accessoryButtonTappedForRow row: Int) {
        
        
    }
    
    public func tableView(tableView: UITableView, accessoryButtonTappedForSubrow subrow: Int, inRow row: Int) {
        
        
    }
    
    override public final func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Void in
                
                self.tableView(tableView, accessoryButtonTappedForRow: row)
                
            }) { (subrow, row) -> Void in
                
            self.tableView(tableView, accessoryButtonTappedForSubrow: subrow, inRow: row)
        }
    }
    
    // ****************
    
    public func tableView(tableView: UITableView, shouldHighlightRow row: Int) -> Bool {
        
        return true
    }
    
    public func tableView(tableView: UITableView, shouldHighlightSubrow subrow: Int, inRow row: Int) -> Bool {
        
        return true
    }
    
    override public final func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Bool in
                
                return self.tableView(tableView, shouldHighlightRow: row)
                
            }, functionForSubrow: { (subrow, row) -> Bool in
                
                return self.tableView(tableView, shouldHighlightSubrow: subrow, inRow: row)
        })
    }
    
    // ****************
    public func tableView(tableView: UITableView, didHighlightRow row: Int) {
        
        
    }
    
    public func tableView(tableView: UITableView, didHighlightSubrow subrow: Int, inRow row: Int) {
        
        
    }
    
    override public final func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        
        self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Void in
                
                self.tableView(tableView, didHighlightRow: row)
                
            }) { (subrow, row) -> Void in
                
                self.tableView(tableView, didHighlightSubrow: subrow, inRow: row)
        }
    }
    
    // ****************
    public func tableView(tableView: UITableView, didUnhighlightRow row: Int) {
        
        
    }
    
    public func tableView(tableView: UITableView, didUnhighlightSubrow subrow: Int, inRow row: Int) {
        
        
    }
    
    override public final func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        
        self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Void in
                
                self.tableView(tableView, didUnhighlightRow: row)
                
            }) { (subrow, row) -> Void in
                
                self.tableView(tableView, didUnhighlightSubrow: subrow, inRow: row)
        }
    }
    
    override public final func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> NSIndexPath? in
                
                return indexPath
                
            },
            functionForSubrow: { (subrow, row) -> NSIndexPath? in
                
                return nil
        })
    }
    
    override public final func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        return indexPath
    }
    
    // ****************
    public func tableView(tableView: UITableView, didSelectRow row: Int) {
        
        
    }
    
    override public final func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var row = indexPath.row
        
        if self.subrows.first == nil { // subrows should be inserted into row
            
            let count = self.tableView(tableView, numberOfSubrowsInRow: row)
            
            tableView.beginUpdates()
            
            for subrow in (0..<count) {
                
                self.insertSubrowAtSubrow(subrow, inRow: row, withRowAnimation: .Automatic)
            }
            
            tableView.endUpdates()
            
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0)) {
                
                cell.accessoryView = self.tableView(tableView, accessoryViewForSelectedRow: row)
            }
            tableView.selectRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.None)
            
        } else if (self.subrows.first! - 1) == row { // subrows should be deleted from row
            
            tableView.beginUpdates()
            
            for subrow in (0..<self.subrows.count).reverse() {
                
                self.deleteSubrowAtSubrow(subrow, inRow: row, withRowAnimation: .Automatic)
            }
            
            tableView.endUpdates()
            
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0)) {
                
                cell.accessoryView = self.tableView(tableView, accessoryViewForDeselectedRow: row)
            }
            tableView.deselectRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0), animated: true)
            
        } else { // subrows should be deleted from row and inserted into (row - deletedCount)
            
            let deletedCount = self.subrows.count
            
            let selectedRow = self.subrows.first! - 1
            
            tableView.beginUpdates()
            
            for subrow in (0..<deletedCount).reverse() {
                
                self.deleteSubrowAtSubrow(subrow, inRow: selectedRow, withRowAnimation: .Automatic)
            }
            
            tableView.endUpdates()
            
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: selectedRow, inSection: 0)) {
                
                if let accessoryView = self.tableView(tableView, accessoryViewForDeselectedRow: selectedRow) {
                    
                    cell.accessoryView = accessoryView
                }
            }
            tableView.deselectRowAtIndexPath(NSIndexPath(forRow: selectedRow, inSection: 0), animated: true)
            
            if row > selectedRow {
                
                row -= deletedCount
            }
            
            let count = self.tableView(tableView, numberOfSubrowsInRow: row)
            
            tableView.beginUpdates()
            
            for subrow in (0..<count) {
                
                self.insertSubrowAtSubrow(subrow, inRow: row, withRowAnimation: .Automatic)
            }
            
            tableView.endUpdates()
            
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0)) {
                
                cell.accessoryView = self.tableView(tableView, accessoryViewForSelectedRow: row)
            }
            tableView.selectRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.None)
        }
    }
    
    // ****************
    public func tableView(tableView: UITableView, didDeselectRow row: Int) {
        
        
    }
    
    override public final func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Void in
                
                self.tableView(tableView, didDeselectRow: row)
                
            }) { (subrow, row) -> Void in
                
                
        }
    }
    
    // ****************
    public func tableView(tableView: UITableView, editingStyleForRow row: Int) -> UITableViewCellEditingStyle {
        
        return .None
    }
    
    public func tableView(tableView: UITableView, editingStyleForSubrow subrow: Int, inRow row: Int) -> UITableViewCellEditingStyle {
        
        return .None
    }
    
    override public final func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> UITableViewCellEditingStyle in
                
                self.tableView(tableView, editingStyleForRow: row)
                
            }) { (subrow, row) -> UITableViewCellEditingStyle in
                
                self.tableView(tableView, editingStyleForSubrow: subrow, inRow: row)
        }
    }
    
    // ****************
    
    /*override public final func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        
        return super.tableView(tableView, titleForDeleteConfirmationButtonForRowAtIndexPath: indexPath)
    }*/
    
    /*override public final func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        return nil
    }*/
    
    // ****************
    public func tableView(tableView: UITableView, shouldIndentWhileEditingRow row: Int) -> Bool {
        
        return false
    }
    
    public func tableView(tableView: UITableView, shouldIndentWhileEditingSubrow subrow: Int, inRow row: Int) -> Bool {
        
        return false
    }
    
    override public final func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Bool in
                
                self.tableView(tableView, shouldIndentWhileEditingRow: row)
                
            }) { (subrow, row) -> Bool in
                
                self.tableView(tableView, shouldIndentWhileEditingSubrow: subrow, inRow: row)
        }
    }
    
    // ****************
    
    public func tableView(tableView: UITableView, willBeginEditingRow row: Int) {
        
    }
    
    public func tableView(tableView: UITableView, willBeginEditingSubrow subrow: Int, inRow row: Int) {
        
    }
    
    override public final func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath) {
        
        self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Void in
                
                self.tableView(tableView, willBeginEditingRow: row)
                
            }) { (subrow, row) -> Void in
                
                self.tableView(tableView, willBeginEditingSubrow: subrow, inRow: row)
        }
    }
    
    // ****************
    public func tableView(tableView: UITableView, didEndEditingRow row: Int) {
        
    }
    
    public func tableView(tableView: UITableView, didEndEditingSubrow subrow: Int, inRow row: Int) {
        
    }
    
    override public final func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {
        
        self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Void in
                
                self.tableView(tableView, didEndEditingRow: row)
                
            }) { (subrow, row) -> Void in
                
                self.tableView(tableView, didEndEditingSubrow: subrow, inRow: row)
        }
    }
    
    // ****************
    
    public func tableView(tableView: UITableView, targetRowForMoveFromRow sourceRow: Int, toProposedRow proposedDestinationRow: Int) -> Int {
        
        return sourceRow
    }
    
    public func tableView(tableView: UITableView, targetSubrowForMoveFromSubrow sourceSubrow: Int, toProposedSubrow proposedDestinationSubrow: Int, inRow row: Int) -> Int {
        
        return sourceSubrow
    }
    
    
    override public final func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        
        if self.subrows.isEmpty {
            
            let targetForRow = self.tableView(tableView, targetRowForMoveFromRow: sourceIndexPath.row,
                toProposedRow: proposedDestinationIndexPath.row)
            
            return NSIndexPath(forRow: targetForRow, inSection: 0)
            
        } else {
            
            if self.subrows.contains(proposedDestinationIndexPath.row) {
                
                let row = self.subrows.first! - 1
                let sourceSubrow = sourceIndexPath.row - row - 1
                let proposedDestinationSubrow = proposedDestinationIndexPath.row - row - 1
                
                let targetSubrow = self.tableView(tableView, targetSubrowForMoveFromSubrow: sourceSubrow, toProposedSubrow: proposedDestinationSubrow, inRow: row)
                
                return NSIndexPath(forRow: targetSubrow + row + 1, inSection: 0)
                
            } else {
                
                return sourceIndexPath
            }
        }
    }
    
    // ****************
    public func tableView(tableView: UITableView, indentationLevelForRow row: Int) -> Int {
        
        if row < self.subrows.first {
            
            return super.tableView(tableView, indentationLevelForRowAtIndexPath: NSIndexPath(forRow: row, inSection: 0))
        } else {
            
            return super.tableView(tableView, indentationLevelForRowAtIndexPath: NSIndexPath(forRow: row + self.subrows.count, inSection: 0))
        }
    }
    
    public func tableView(tableView: UITableView, indentationLevelForSubrow subrow: Int, inRow row: Int) -> Int {
        
        return super.tableView(tableView, indentationLevelForRowAtIndexPath: NSIndexPath(forRow: row + subrow + 1, inSection: 0))
    }
    
    override public final func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Int in
                
                self.tableView(tableView, indentationLevelForRow: row)
                
            }) { (subrow, row) -> Int in
                
                self.tableView(tableView, indentationLevelForSubrow: subrow, inRow: subrow)
        }
    }
    
    override public final func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        // may be, it will be reimplemented in future
        
        return false
    }
    
    override public final func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        
        // may be, it will be reimplemented in future
        
        return false
    }
    
    override public final func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        
        // may be, it will be reimplemented in future
    }
}
// 977
private extension DropDownTableViewController {
    
    private func functionForIndexPath<T>(indexPath: NSIndexPath, functionForRow: (row: Int) -> T, functionForSubrow: (subrow: Int, row: Int) -> T) -> T {
        
        let row = indexPath.row
        
        if self.subrows.contains(row) {
            
            return functionForSubrow(subrow: row - self.subrows.first!, row: self.subrows.first! - 1)
            
        } else {
            
            var index = row
            
            if index > self.subrows.last {
                
                index -= self.subrows.count
            }
            return functionForRow(row: index)
        }
    }
}

private extension Array where Element: IntegerType {
    
    mutating func extend(elem: Element) {
        
        if let last = self.last {
            
            self.append(last + 1)
            
        } else {
            
            self.append(elem)
        }
    }
}