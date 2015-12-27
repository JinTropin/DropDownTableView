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

@available(iOS 7.0, *)
@objc protocol DropDownTableViewDataSource : NSObjectProtocol {
    
    func numberOfRowsInTableView(tableView: UITableView) -> Int // Default is 0
    
    optional func tableView(tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int // Default is 0
    
    func tableView(tableView: UITableView, cellForRow row: Int, indexPath: NSIndexPath) -> UITableViewCell // must be overriden in child class
    
    func tableView(tableView: UITableView, cellForSubrow subrow: Int, row: Int, indexPath: NSIndexPath) -> UITableViewCell // must be overriden in child class
    
    optional func titleForHeaderInTableView(tableView: UITableView) -> String?  // Default is nil
    
    optional func titleForFooterInTableView(tableView: UITableView) -> String?  // Default is nil
    
    optional func tableView(tableView: UITableView, accessoryViewForSelectedRow row: Int) -> UIView?  // Default is nil
    
    optional func tableView(tableView: UITableView, accessoryViewForDeselectedRow row: Int) -> UIView?  // Default is nil
}

@available(iOS 7.0, *)
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
    
    optional func tableView(tableView: UITableView, indentationLevelForRow row: Int) -> Int
    
    optional func tableView(tableView: UITableView, indentationLevelForSubrow subrow: Int, row: Int) -> Int
}

private var ddRow: UInt8 = 0
private var ddSubrow: UInt8 = 0

@available(iOS 7.0, *)
class DropDownTableViewController: UITableViewController, DropDownTableViewDataSource, DropDownTableViewDelegate {
    
    private var subrows = [Int]()
    private var selectedRow: Int?
    
    override final func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func cellForRow(row: Int) -> UITableViewCell? {
        
        if row < self.subrows.first {
            
            return self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0))
            
        } else {
            
            return self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row + self.subrows.count, inSection: 0))
        }
    }
    
    func cellForSubrow(subrow: Int, row: Int) -> UITableViewCell? {
        
        guard subrow <= (self.subrows.count - 1) else {
            
            return nil
        }
        
        if row + 1 == self.subrows.first {
            
            return self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row + subrow + 1, inSection: 0))
        }
        return nil
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
    
    // ****************
    func tableView(tableView: UITableView, cellForRow row: Int, indexPath: NSIndexPath) -> UITableViewCell {
        
        fatalError(__FUNCTION__ + " has not been implemented")
    }
    
    func tableView(tableView: UITableView, cellForSubrow subrow: Int, row: Int, indexPath: NSIndexPath) -> UITableViewCell {
        
        fatalError(__FUNCTION__ + " has not been implemented")
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
            
            let cellForSubrow = self.tableView(tableView, cellForSubrow: row - self.subrows.first!, row: self.subrows.first! - 1, indexPath: indexPath)
            
            objc_setAssociatedObject(cellForSubrow,
                &ddRow, self.subrows.first! - 1, .OBJC_ASSOCIATION_ASSIGN)
            objc_setAssociatedObject(cellForSubrow,
                &ddSubrow, row - self.subrows.first!, .OBJC_ASSOCIATION_ASSIGN)
            
            return cellForSubrow
            
        } else {
            
            var index = row
            
            if index > self.subrows.last {
                
                index -= self.subrows.count
            }
            
            let cellForRow = self.tableView(tableView, cellForRow: index, indexPath: indexPath)
            
            objc_setAssociatedObject(cellForRow,
                &ddRow, index, .OBJC_ASSOCIATION_ASSIGN)
            objc_setAssociatedObject(cellForRow,
                &ddSubrow, nil, .OBJC_ASSOCIATION_ASSIGN)
            
            let accessoryViewForSelectedRow = self.tableView(tableView, accessoryViewForSelectedRow: index)
            
            let accessoryViewForDeselectedRow = self.tableView(tableView, accessoryViewForDeselectedRow: index)
            
            if row + 1 == self.subrows.first {
                
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
        
        return super.tableView(tableView, titleForHeaderInSection: 0)
    }
    
    override final func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.titleForHeaderInTableView(tableView)
    }
    
    // ****************
    func titleForFooterInTableView(tableView: UITableView) -> String? {
        
        return super.tableView(tableView, titleForFooterInSection: 0)
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
            
            var index = row
            
            if index > self.subrows.last {
                
                index -= self.subrows.count
            }
            
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
        
        // this function is not implemented... yet
        
        let row = objc_getAssociatedObject(cell, &ddRow) as! Int
        
        if let subrow = objc_getAssociatedObject(cell, &ddSubrow) as? Int {
            
            self.tableView(tableView, didEndDisplayingCell: cell, forSubrow: subrow, row: row)
        } else {
            
            self.tableView(tableView, didEndDisplayingCell: cell, forRow: row)
        }
        
        //let row = indexPath.row
        
        //print(row, self.subrows)
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
        
        if row < self.subrows.first {
            
            return super.tableView(tableView, heightForRowAtIndexPath: NSIndexPath(forRow: row, inSection: 0))
        } else {
            
            return super.tableView(tableView, heightForRowAtIndexPath: NSIndexPath(forRow: row + self.subrows.count, inSection: 0))
        }
    }
    
    // ****************
    func tableView(tableView: UITableView, heightForSubrow subrow: Int, row: Int) -> CGFloat {
        
        return super.tableView(tableView, heightForRowAtIndexPath: NSIndexPath(forRow: row + subrow + 1, inSection: 0))
    }
    
    override final func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let row = indexPath.row
        
        if self.subrows.contains(row) {
            
            return self.tableView(tableView, heightForSubrow: row - self.subrows.first!, row: self.subrows.first! - 1)
            
        } else {
            
            var index = row
            
            if index > self.subrows.last {
                
                index -= self.subrows.count
            }
            return self.tableView(tableView, heightForRow: index)
        }
    }
    
    func heightForHeaderInTableView(tableView: UITableView) -> CGFloat {
        
        return super.tableView(tableView, heightForHeaderInSection: 0)
    }
    
    override final func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return self.heightForHeaderInTableView(tableView)
    }
    
    func heightForFooterInTableView(tableView: UITableView) -> CGFloat {
        
        return super.tableView(tableView, heightForFooterInSection: 0)
    }
    
    override final func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return self.heightForFooterInTableView(tableView)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRow row: Int) -> CGFloat {
        
        return tableView.rowHeight //tableView.estimatedRowHeight
    }
    
    func tableView(tableView: UITableView, estimatedHeightForSubrow subrow: Int, row: Int) -> CGFloat {
        
        return tableView.rowHeight //tableView.estimatedRowHeight
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let row = indexPath.row
        
        if self.subrows.contains(row) {
            
            return self.tableView(tableView, estimatedHeightForSubrow: row - self.subrows.first!, row: self.subrows.first! - 1)
            
        } else {
            
            var index = row
            
            if index > self.subrows.last {
                
                index -= self.subrows.count
            }
            
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
        
        return super.tableView(tableView, viewForHeaderInSection: 0)
    }
    
    override final func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return self.viewForHeaderInTableView(tableView)
    }
    
    func viewForFooterInTableView(tableView: UITableView) -> UIView? {
        
        return super.tableView(tableView, viewForFooterInSection: 0)
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return self.viewForFooterInTableView(tableView)
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRow row: Int) {
        
        if row < self.subrows.first {
            
            super.tableView(tableView, accessoryButtonTappedForRowWithIndexPath: NSIndexPath(forRow: row, inSection: 0))
        } else {
            
            super.tableView(tableView, accessoryButtonTappedForRowWithIndexPath: NSIndexPath(forRow: row + self.subrows.count, inSection: 0))
        }
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForSubrow subrow: Int, row: Int) {
        
        super.tableView(tableView, accessoryButtonTappedForRowWithIndexPath: NSIndexPath(forRow: row + subrow + 1, inSection: 0))
    }
    
    override final func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        let row = indexPath.row
        
        if self.subrows.contains(row) {
            
            self.tableView(tableView, accessoryButtonTappedForSubrow: row - self.subrows.first!, row: self.subrows.first! - 1)
            
        } else {
            
            var index = row
            
            if index > self.subrows.last {
                
                index -= self.subrows.count
            }
            
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
            
            var index = row
            
            if index > self.subrows.last {
                
                index -= self.subrows.count
            }
            
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
            
            var index = row
            
            if index > self.subrows.last {
                
                index -= self.subrows.count
            }
            
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
        
        if self.selectedRow == nil { // subrows should be inserted into row
            
            let count = self.tableView(tableView, numberOfSubrowsInRow : row)
            
            for var index = row + 1; index <= row + count; index++ {
                
                self.subrows.append(index)
                
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Automatic)
            }
            
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0)) {
                
                cell.accessoryView = self.tableView(tableView, accessoryViewForSelectedRow: row)
            }
            tableView.selectRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.None)
            
            self.selectedRow = row
            
        } else if self.selectedRow! == row { // subrows should be deleted from row
            
            for index in self.subrows.reverse() {
                
                self.subrows.removeLast()
                
                tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Automatic)
            }
            
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0)) {
                
                cell.accessoryView = self.tableView(tableView, accessoryViewForDeselectedRow: row)
            }
            tableView.deselectRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0), animated: true)
            
            self.selectedRow = nil
            
        } else { // subrows should be deleted from row and inserted into (row - deletedCount)
            
            let deletedCount = self.subrows.count
            
            for index in self.subrows.reverse() {
                
                self.subrows.removeLast()
                
                tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Automatic)
            }
            
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: self.selectedRow!, inSection: 0)) {
                
                if let accessoryView = self.tableView(tableView, accessoryViewForDeselectedRow: self.selectedRow!) {
                    
                    cell.accessoryView = accessoryView
                }
            }
            tableView.deselectRowAtIndexPath(NSIndexPath(forRow: self.selectedRow!, inSection: 0), animated: true)
            
            
            if row > self.selectedRow! {
                
                row -= deletedCount
            }
            
            let count = self.tableView(tableView, numberOfSubrowsInRow : row)
            
            for var index = row + 1; index <= row + count; index++ {
                
                self.subrows.append(index)
                
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Automatic)
            }
            
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0)) {
                
                cell.accessoryView = self.tableView(tableView, accessoryViewForSelectedRow: row)
            }
            tableView.selectRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.None)
            
            self.selectedRow = row
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRow row: Int) {
        
        
    }
    
    override final func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        let row = indexPath.row
        
        var index = row
            
        if index > self.subrows.last {
                
            index -= self.subrows.count
        }
        self.tableView(tableView, didDeselectRow: index)
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
    
    func tableView(tableView: UITableView, indentationLevelForRow row: Int) -> Int {
        
        if row < self.subrows.first {
            
            return super.tableView(tableView, indentationLevelForRowAtIndexPath: NSIndexPath(forRow: row, inSection: 0))
        } else {
            
            return super.tableView(tableView, indentationLevelForRowAtIndexPath: NSIndexPath(forRow: row + self.subrows.count, inSection: 0))
        }
    }
    
    func tableView(tableView: UITableView, indentationLevelForSubrow subrow: Int, row: Int) -> Int {
        
        return super.tableView(tableView, indentationLevelForRowAtIndexPath: NSIndexPath(forRow: row + subrow + 1, inSection: 0))
    }
    
    override final func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        
        let row = indexPath.row
        
        if self.subrows.contains(row) {
            
            return self.tableView(tableView, indentationLevelForSubrow: row - self.subrows.first!, row: self.subrows.first! - 1)
            
        } else {
            
            var index = row
            
            if index > self.subrows.last {
                
                index -= self.subrows.count
            }
            return self.tableView(tableView, indentationLevelForRow: index)
        }
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
        
        return true
    }
    
    override final func tableView(tableView: UITableView, shouldUpdateFocusInContext context: UITableViewFocusUpdateContext) -> Bool {
        
        // may be, it will be reimplemented in future
        
        return true
    }
    
    override final func tableView(tableView: UITableView, didUpdateFocusInContext context: UITableViewFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        // may be, it will be reimplemented in future
    }
    
    override final func indexPathForPreferredFocusedViewInTableView(tableView: UITableView) -> NSIndexPath? {
        
        // may be, it will be reimplemented in future
        
        return nil
    }
}
