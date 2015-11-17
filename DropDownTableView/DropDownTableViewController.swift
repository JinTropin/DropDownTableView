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

extension Array where Element: IntegerType {
    
    func subtract(other: Array) -> Array {
        
        return Set(self).subtract(Set(other)).sort()
    }
}

@objc protocol DropDownTableViewDataSource : NSObjectProtocol {
    
    func numberOfRowsInTableView(tableView: UITableView) -> Int // Default is 0
    
    optional func tableView(tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int // Default is 0
    
    func tableView(tableView: UITableView, cellForRow row: Int, indexPath: NSIndexPath) -> UITableViewCell
    
    func tableView(tableView: UITableView, cellForSubrow subrow: Int, row: Int, indexPath: NSIndexPath) -> UITableViewCell
    
    optional func titleForHeaderInTableView(tableView: UITableView) -> String?  // Default is nil
    
    optional func titleForFooterInTableView(tableView: UITableView) -> String?  // Default is nil
    
    optional func tableView(tableView: UITableView, accessoryViewForSelectedRow row: Int) -> UIView?  // Default is nil
    
    optional func tableView(tableView: UITableView, accessoryViewForDeselectedRow row: Int) -> UIView?  // Default is nil
}

@objc protocol DropDownTableViewDelegate : NSObjectProtocol {
    
    optional func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRow row: Int)
    
    optional func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forSubrow subrow: Int, row: Int)
    
    optional func tableView(tableView: UITableView, willDisplayHeaderView view: UIView)
    
    optional func tableView(tableView: UITableView, willDisplayFooterView view: UIView)
    
    optional func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRow row: Int)
    
    optional func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forSubrow subrow: Int, row: Int)
    
    optional func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView)
    
    optional func tableView(tableView: UITableView, didEndDisplayingFooterView view: UIView)
    
    optional func tableView(tableView: UITableView, heightForRow row: Int) -> CGFloat
    
    optional func tableView(tableView: UITableView, heightForSubrow subrow: Int, row: Int) -> CGFloat
    
    optional func heightForHeaderInTableView(tableView: UITableView) -> CGFloat
    
    optional func heightForFooterInTableView(tableView: UITableView) -> CGFloat
    
    optional func tableView(tableView: UITableView, estimatedHeightForRow row: Int) -> CGFloat
    
    optional func tableView(tableView: UITableView, estimatedHeightForSubrow subrow: Int, row: Int) -> CGFloat
    
    optional func estimatedHeightForHeaderInTableView(tableView: UITableView) -> CGFloat
    
    optional func estimatedHeightForFooterInTableView(tableView: UITableView) -> CGFloat
    
    optional func viewForHeaderInTableView(tableView: UITableView) -> UIView?
    
    optional func viewForFooterInTableView(tableView: UITableView) -> UIView?
    
    optional func tableView(tableView: UITableView, accessoryButtonTappedForRow row: Int)
    
    optional func tableView(tableView: UITableView, accessoryButtonTappedForSubrow subrow: Int, row: Int)
    
    optional func tableView(tableView: UITableView, didHighlightRow row: Int)
    
    optional func tableView(tableView: UITableView, didHighlightSubrow subrow: Int, row: Int)
    
    optional func tableView(tableView: UITableView, didUnhighlightRow row: Int)
    
    optional func tableView(tableView: UITableView, didUnhighlightSubrow subrow: Int, row: Int)
    
    optional func tableView(tableView: UITableView, didSelectRow row: Int)
    
    optional func tableView(tableView: UITableView, didDeselectRow row: Int)
}

class DropDownTableViewController: UITableViewController, DropDownTableViewDataSource, DropDownTableViewDelegate {
    
    private var subrows = [Int]()
    private var previousSubrows = [Int]()
    
    override final func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    // DropDownTableViewDataSource implementation
    
    // ****************
    func numberOfRowsInTableView(tableView: UITableView) -> Int {
        
        return 0
    }
    
    override final func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.numberOfRowsInTableView(tableView) + self.subrows.count
    }
    
    // ****************
    func tableView(tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int {
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRow row: Int, indexPath: NSIndexPath) -> UITableViewCell {
        
        fatalError(__FUNCTION__ + " has not been implemented")
    }
    
    func tableView(tableView: UITableView, cellForSubrow subrow: Int, row: Int, indexPath: NSIndexPath) -> UITableViewCell {
        
        fatalError(__FUNCTION__ + " has not been implemented")
    }
    
    private func mainRows(n: Int) -> [Int] {
        
        return [Int](0..<n).subtract(self.subrows)
    }
    
    func tableView(tableView: UITableView, accessoryViewForSelectedRow row: Int) -> UIView? {
        
        return nil
    }
    
    func tableView(tableView: UITableView, accessoryViewForDeselectedRow row: Int) -> UIView? {
        
        return nil
    }
    
    override final func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        if self.subrows.contains(row) {
            
            return self.tableView(tableView, cellForSubrow: row - self.subrows.first!, row: self.subrows.first! - 1, indexPath: indexPath)
            
        } else {
            
            let mainRows = self.mainRows(self.numberOfRowsInTableView(tableView) + self.subrows.count)
            
            let index = mainRows.indexOf(row)!
            
            let cellForRow = self.tableView(tableView, cellForRow: index, indexPath: indexPath)
            
            let accessoryViewForSelectedRow = self.tableView(tableView, accessoryViewForSelectedRow: index)
            
            let accessoryViewForDeselectedRow = self.tableView(tableView, accessoryViewForDeselectedRow: index)
            
            if index + 1 == self.subrows.first {
                
                if accessoryViewForSelectedRow != nil {
                    
                    cellForRow.accessoryView = accessoryViewForSelectedRow
                }
                
            } else if accessoryViewForDeselectedRow != nil {
                
                cellForRow.accessoryView = accessoryViewForDeselectedRow
            }
            
            return cellForRow
        }
    }
    
    // ****************
    func titleForHeaderInTableView(tableView: UITableView) -> String? {
        
        return nil
    }
    
    override final func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.titleForHeaderInTableView(tableView)
    }
    
    // ****************
    func titleForFooterInTableView(tableView: UITableView) -> String? {
        
        return nil
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return self.titleForFooterInTableView(tableView)
    }
    
    override final func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        // may be, it will be reimplemented in future
        
        return false
    }
    
    override final func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        // may be, it will be reimplemented in future
        
        return false
    }
    
    override final func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        
        // may be, it will be reimplemented in future
        
        return nil
    }
    
    override final func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        
        // may be, it will be reimplemented in future
        
        return 0
    }
    
    override final func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    override final func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        
    }
        
    // DropDownTableViewDelegate implementation
    
    // ****************
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRow row: Int) {
        
    }
    
    // ****************
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forSubrow subrow: Int, row: Int) {
        
    }
    
    override final func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let row = indexPath.row
        
        if self.subrows.contains(row) {
            
            self.tableView(tableView, willDisplayCell: cell, forSubrow: row - self.subrows.first!, row: self.subrows.first! - 1)
            
        } else {
            
            let mainRows = self.mainRows(self.numberOfRowsInTableView(tableView) + self.subrows.count)
            
            let index = mainRows.indexOf(row)!
            
            self.tableView(tableView, willDisplayCell: cell, forRow: index)
        }
    }
    
    // ****************
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView) {
        
    }
    
    override final func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            
        self.tableView(tableView, willDisplayHeaderView: view)
    }
    
    // ****************
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView) {
        
    }
    
    override final func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
            
        self.tableView(tableView, willDisplayFooterView: view)
    }
    
    // ****************
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRow row: Int) {
        
    }
    
    // ****************
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forSubrow subrow: Int, row: Int) {
        
    }
    
    override final func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let row = indexPath.row
        
        if self.previousSubrows.contains(row) {
            
            self.tableView(tableView, didEndDisplayingCell: cell, forSubrow: row - self.previousSubrows.first!, row: self.previousSubrows.first! - 1)
            
        } else if row < self.previousSubrows.first {
            
            self.tableView(tableView, didEndDisplayingCell: cell, forRow: row)
            
        } else {
            
            self.tableView(tableView, didEndDisplayingCell: cell, forRow: row - self.previousSubrows.count)
        }
        
        /*let row = indexPath.row
        
        if self.previousSubrows.contains(row) {
            
            self.tableView(tableView, didEndDisplayingCell: cell, forSubrow: row - self.previousSubrows.first!, row: self.previousSubrows.first! - 1)
            
        } else {
            
            let mainRows = self.mainRows(self.numberOfRowsInTableView(tableView) + self.previousSubrows.count)
            
            let index = mainRows.indexOf(row)!
            
            self.tableView(tableView, didEndDisplayingCell: cell, forRow: index)
        }*/
    }
    
    // ****************
    func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView) {
        
    }
    
    override final func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
            
        self.tableView(tableView, didEndDisplayingHeaderView: view)
    }
    
    // ****************
    func tableView(tableView: UITableView, didEndDisplayingFooterView view: UIView) {
        
    }
    
    override final func tableView(tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
            
        self.tableView(tableView, didEndDisplayingFooterView: view)
    }
    
    // ****************
    func tableView(tableView: UITableView, heightForRow row: Int) -> CGFloat {
        
        var indexPath: NSIndexPath!
        
        if row < self.subrows.first {
            
            indexPath = NSIndexPath(forRow: row, inSection: 0)
        } else {
            
            indexPath = NSIndexPath(forRow: row - self.subrows.count, inSection: 0)
        }
        
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    // ****************
    func tableView(tableView: UITableView, heightForSubrow subrow: Int, row: Int) -> CGFloat {
        
        return super.tableView(tableView, heightForRowAtIndexPath: NSIndexPath(forRow: row + subrow + 1, inSection: 0))
        
        //return 44
    }
    
    override final func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let row = indexPath.row
        
        if self.subrows.contains(row) {
            
            return self.tableView(tableView, heightForSubrow: row - self.subrows.first!, row: self.subrows.first! - 1)
            
        } else {
            
            let mainRows = self.mainRows(self.numberOfRowsInTableView(tableView) + self.subrows.count)
            
            let index = mainRows.indexOf(row)!
            
            return self.tableView(tableView, heightForRow: index)
        }
    }
    
    func heightForHeaderInTableView(tableView: UITableView) -> CGFloat {
        
        return 0//tableView.sectionHeaderHeight
    }
    
    override final func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return self.heightForHeaderInTableView(tableView)
    }
    
    func heightForFooterInTableView(tableView: UITableView) -> CGFloat {
        
        return 0//tableView.sectionFooterHeight
    }
    
    override final func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return self.heightForFooterInTableView(tableView)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRow row: Int) -> CGFloat {
        
        return 44//tableView.estimatedRowHeight
    }
    
    func tableView(tableView: UITableView, estimatedHeightForSubrow subrow: Int, row: Int) -> CGFloat {
        
        return 44//tableView.estimatedRowHeight
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let row = indexPath.row
        
        if self.subrows.contains(row) {
            
            return self.tableView(tableView, estimatedHeightForSubrow: row - self.subrows.first!, row: self.subrows.first! - 1)
            
        } else {
            
            let mainRows = self.mainRows(self.numberOfRowsInTableView(tableView) + self.subrows.count)
            
            let index = mainRows.indexOf(row)!
            
            return self.tableView(tableView, estimatedHeightForRow: index)
        }
    }
    
    func estimatedHeightForHeaderInTableView(tableView: UITableView) -> CGFloat {
        
        return tableView.estimatedSectionHeaderHeight
    }
    
    override final func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        
        return self.estimatedHeightForHeaderInTableView(tableView)
    }
    
    func estimatedHeightForFooterInTableView(tableView: UITableView) -> CGFloat {
        
        return tableView.estimatedSectionFooterHeight
    }
    
    override final func tableView(tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        
        return self.estimatedHeightForFooterInTableView(tableView)
    }
    
    func viewForHeaderInTableView(tableView: UITableView) -> UIView? {
        
        return nil
    }
    
    override final func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return self.viewForHeaderInTableView(tableView)
    }
    
    func viewForFooterInTableView(tableView: UITableView) -> UIView? {
        
        return nil
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return self.viewForFooterInTableView(tableView)
    }
    
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRow row: Int) {
        
        
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForSubrow subrow: Int, row: Int) {
        
    }
    
    override final func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        let row = indexPath.row
        
        if self.subrows.contains(row) {
            
            self.tableView(tableView, accessoryButtonTappedForSubrow: row - self.subrows.first!, row: self.subrows.first! - 1)
            
        } else {
            
            let mainRows = self.mainRows(self.numberOfRowsInTableView(tableView) + self.subrows.count)
            
            let index = mainRows.indexOf(row)!
            
            self.tableView(tableView, accessoryButtonTappedForRow: index)
        }
    }
    
    override final func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return !self.subrows.contains(indexPath.row)
    }
    
    func tableView(tableView: UITableView, didHighlightRow row: Int) {
        
    }
    
    func tableView(tableView: UITableView, didHighlightSubrow subrow: Int, row: Int) {
        
    }
    
    override final func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        
        let row = indexPath.row
        
        if self.subrows.contains(row) {
            
            self.tableView(tableView, didHighlightSubrow: row - self.subrows.first!, row: self.subrows.first! - 1)
            
        } else {
            
            let mainRows = self.mainRows(self.numberOfRowsInTableView(tableView) + self.subrows.count)
            
            let index = mainRows.indexOf(row)!
            
            self.tableView(tableView, didHighlightRow: index)
        }
    }
    
    func tableView(tableView: UITableView, didUnhighlightRow row: Int) {
        
    }
    
    func tableView(tableView: UITableView, didUnhighlightSubrow subrow: Int, row: Int) {
        
    }
    
    override final func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        
        let row = indexPath.row
        
        if self.subrows.contains(row) {
            
            self.tableView(tableView, didUnhighlightSubrow: row - self.subrows.first!, row: self.subrows.first! - 1)
            
        } else {
            
            let mainRows = self.mainRows(self.numberOfRowsInTableView(tableView) + self.subrows.count)
            
            let index = mainRows.indexOf(row)!
            
            self.tableView(tableView, didUnhighlightRow: index)
        }
    }
    
    override final func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        return indexPath
    }
    
    override final func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRow row: Int) {
        
    }
    
    override final func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var row = indexPath.row
        
        if self.previousSubrows.last < row {
            
            row -= self.previousSubrows.count
        }
        
        if self.subrows.isEmpty {
            
            let count = self.tableView(tableView, numberOfSubrowsInRow : row)
            
            for var index = row + 1; index <= row + count; index++ {
                
                self.subrows.append(index)
                
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Automatic)
            }
            self.previousSubrows = []
            
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0)) {
                
                cell.accessoryView = self.tableView(tableView, accessoryViewForSelectedRow: row)
            }
            
            tableView.selectRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.None)
            
        } else {
            
            self.previousSubrows = self.subrows
            
            for index in self.subrows.reverse() {
                
                self.subrows.removeLast()
                
                tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Automatic)
            }
            
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0)) {
                
                cell.accessoryView = self.tableView(tableView, accessoryViewForDeselectedRow: row)
            }
            
            tableView.deselectRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0), animated: true)
            
        }
        
        self.tableView(tableView, didSelectRow: row)
    }
    
    func tableView(tableView: UITableView, didDeselectRow row: Int) {
        
        
    }
    
    override final func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        var row = indexPath.row
        
        if self.subrows.last < row {
            
            row -= self.subrows.count
        }
        
        self.previousSubrows = self.subrows
        
        for index in self.subrows.reverse() {
            
            self.subrows.removeLast()
            
            tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Automatic)
        }
        
        if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0)) {
            
            cell.accessoryView = self.tableView(tableView, accessoryViewForDeselectedRow: row)
        }
        
        self.tableView(tableView, didDeselectRow: row)
    }
    
    override final func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        // may be, it will be reimplemented in future
        
        return .None
    }
    
    override final func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        
        // may be, it will be reimplemented in future
        
        return nil
    }
    
    override final func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        // may be, it will be reimplemented in future
        
        return nil
    }
    
    override final func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        // may be, it will be reimplemented in future
        
        return false
    }
    
    override final func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath) {
        
        // may be, it will be reimplemented in future
    }

    override final func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {
        
        // may be, it will be reimplemented in future
    }
    
    override final func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        
        // may be, it will be reimplemented in future
        
        return sourceIndexPath
    }
    
    override final func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        
        // may be, it will be reimplemented in future
        
        return 0
    }
    
    override final func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        // may be, it will be reimplemented in future
        
        return false
    }

    override final func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        
        // may be, it will be reimplemented in future
        
        return false
    }
    
    override final func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        
        // may be, it will be reimplemented in future
    }
    
    override final func tableView(tableView: UITableView, canFocusRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        // may be, it will be reimplemented in future
        
        return false
    }
    
    override final func tableView(tableView: UITableView, shouldUpdateFocusInContext context: UITableViewFocusUpdateContext) -> Bool {
        
        // may be, it will be reimplemented in future
        
        return false
    }
    
    override final func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        // may be, it will be reimplemented in future
    }
    
    override final func indexPathForPreferredFocusedViewInTableView(tableView: UITableView) -> NSIndexPath? {
        
        // may be, it will be reimplemented in future
        
        return nil
    }
}


