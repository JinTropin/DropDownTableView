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
/*@objc */public protocol DropDownTableViewDataSource : NSObjectProtocol {
    
    func tableView(tableView: UITableView, indexPathsForRows rows: [Int]) -> [NSIndexPath] // [NSIndexPath(forRow:inSection)]
    
    func tableView(tableView: UITableView, indexPathsForSubrows subrows: [Int], inRow row: Int) -> [NSIndexPath] // [NSIndexPath(forRow:inSection)]
    
    func functionForIndexPath<T>(indexPath: NSIndexPath, functionForRow: (row: Int) -> T, functionForSubrow: (subrow: Int, row: Int) -> T) -> T
    
    
    
    func numberOfRowsInTableView(tableView: UITableView) -> Int // Default is 0
    /*optional*/ func tableView(tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int // Default is 0
    
    func tableView(tableView: UITableView, cellForRow row: Int, indexPath: NSIndexPath) -> UITableViewCell // must be overriden in child class
    func tableView(tableView: UITableView, cellForSubrow subrow: Int, inRow row: Int, indexPath: NSIndexPath) -> UITableViewCell // must be overriden in child class
    
    /*optional*/ func titleForHeaderInTableView(tableView: UITableView) -> String?  // Default is nil
    /*optional*/ func titleForFooterInTableView(tableView: UITableView) -> String?  // Default is nil
    
    /*optional*/ func tableView(tableView: UITableView, canEditRow row: Int) -> Bool // default is false
    /*optional*/ func tableView(tableView: UITableView, canEditSubrow subrow: Int, inRow row: Int) -> Bool // default is false
    
    /*optional*/ func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRow row: Int)
    /*optional*/ func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forSubrow subrow: Int, inRow row: Int)
    
    /*optional*/ func tableView(tableView: UITableView, canMoveRow row: Int) -> Bool // default is false
    /*optional*/ func tableView(tableView: UITableView, canMoveSubrow subrow: Int, inRow row: Int) -> Bool // default is false
    
    /*optional*/ func tableView(tableView: UITableView, accessoryViewForSelectedRow row: Int) -> UIView?  // Default is nil
    /*optional*/ func tableView(tableView: UITableView, accessoryViewForDeselectedRow row: Int) -> UIView?  // Default is nil
    
    /*optional*/ func tableView(tableView: UITableView, moveRow sourceRow: Int, toRow destinationRow: Int)
    /*optional*/ func tableView(tableView: UITableView, moveSubrow sourceSubrow: Int, toSubrow destinationSubrow: Int, inRow row: Int)
}

@available(iOS 8.0, *)
/*@objc */public protocol DropDownTableViewDelegate : NSObjectProtocol {
    
    /*optional*/ func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRow row: Int)
    /*optional*/ func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forSubrow subrow: Int, inRow row: Int)
    
    /*optional*/ func tableView(tableView: UITableView, willDisplayHeaderView view: UIView)
    /*optional*/ func tableView(tableView: UITableView, willDisplayFooterView view: UIView)
    
    /*optional*/ func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRow row: Int)
    /*optional*/ func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forSubrow subrow: Int, inRow row: Int)
    
    /*optional*/ func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView)
    /*optional*/ func tableView(tableView: UITableView, didEndDisplayingFooterView view: UIView)
    
    /*optional*/ func tableView(tableView: UITableView, heightForRow row: Int) -> CGFloat
    /*optional*/ func tableView(tableView: UITableView, heightForSubrow subrow: Int, inRow row: Int) -> CGFloat
    
    /*optional*/ func heightForHeaderInTableView(tableView: UITableView) -> CGFloat
    /*optional*/ func heightForFooterInTableView(tableView: UITableView) -> CGFloat
    
    /*optional*/ func tableView(tableView: UITableView, estimatedHeightForRow row: Int) -> CGFloat
    /*optional*/ func tableView(tableView: UITableView, estimatedHeightForSubrow subrow: Int, inRow row: Int) -> CGFloat
    
    /*optional*/ func estimatedHeightForHeaderInTableView(tableView: UITableView) -> CGFloat
    /*optional*/ func estimatedHeightForFooterInTableView(tableView: UITableView) -> CGFloat
    
    /*optional*/ func viewForHeaderInTableView(tableView: UITableView) -> UIView?
    /*optional*/ func viewForFooterInTableView(tableView: UITableView) -> UIView?
    
    /*optional*/ func tableView(tableView: UITableView, accessoryButtonTappedForRow row: Int)
    /*optional*/ func tableView(tableView: UITableView, accessoryButtonTappedForSubrow subrow: Int, inRow row: Int)
    
    /*optional*/ func tableView(tableView: UITableView, shouldHighlightRow row: Int) -> Bool
    /*optional*/ func tableView(tableView: UITableView, shouldHighlightSubrow subrow: Int, inRow row: Int) -> Bool
    
    /*optional*/ func tableView(tableView: UITableView, didHighlightRow row: Int)
    /*optional*/ func tableView(tableView: UITableView, didHighlightSubrow subrow: Int, inRow row: Int)
    
    /*optional*/ func tableView(tableView: UITableView, didUnhighlightRow row: Int)
    /*optional*/ func tableView(tableView: UITableView, didUnhighlightSubrow subrow: Int, inRow row: Int)
    
    /*optional*/ func tableView(tableView: UITableView, didSelectRow row: Int)
    /*optional*/ func tableView(tableView: UITableView, didDeselectRow row: Int)
    
    /*optional*/ func tableView(tableView: UITableView, editingStyleForRow row: Int) -> UITableViewCellEditingStyle // default is .None
    /*optional*/ func tableView(tableView: UITableView, editingStyleForSubrow subrow: Int, inRow row: Int) -> UITableViewCellEditingStyle // default is .None
    
    /*optional*/ func tableView(tableView: UITableView, editActionsForRow row: Int) -> [UITableViewRowAction]?
    /*optional*/ func tableView(tableView: UITableView, editActionsForSubrow subrow: Int, inRow row: Int) -> [UITableViewRowAction]?
    
    /*optional*/ func tableView(tableView: UITableView, indentationLevelForRow row: Int) -> Int
    /*optional*/ func tableView(tableView: UITableView, indentationLevelForSubrow subrow: Int, inRow row: Int) -> Int
    
    /*optional*/ func tableView(tableView: UITableView, shouldShowMenuForRow row: Int) -> Bool
    /*optional*/ func tableView(tableView: UITableView, shouldShowMenuForSubrow subrow: Int, inRow row: Int) -> Bool
    
    /*optional*/ func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtRow row: Int, withSender sender: AnyObject?) -> Bool
    /*optional*/ func tableView(tableView: UITableView, canPerformAction action: Selector, forSubrow subrow: Int, inRow row: Int, withSender sender: AnyObject?) -> Bool
    
    /*optional*/ func tableView(tableView: UITableView, performAction action: Selector, forRowAtRow row: Int, withSender sender: AnyObject?)
    /*optional*/ func tableView(tableView: UITableView, performAction action: Selector, forSubrow subrow: Int, inRow row: Int, withSender sender: AnyObject?)
    
    /*optional*/ func tableView(tableView: UITableView, shouldIndentWhileEditingRow row: Int) -> Bool // default is false
    /*optional*/ func tableView(tableView: UITableView, shouldIndentWhileEditingSubrow subrow: Int, inRow row: Int) -> Bool // default is false
    
    /*optional*/ func tableView(tableView: UITableView, willBeginEditingRow row: Int)
    /*optional*/ func tableView(tableView: UITableView, willBeginEditingSubrow subrow: Int, inRow row: Int)
    
    /*optional*/ func tableView(tableView: UITableView, didEndEditingRow row: Int)
    /*optional*/ func tableView(tableView: UITableView, didEndEditingSubrow subrow: Int, inRow row: Int)
    
    /*optional*/ func tableView(tableView: UITableView, targetRowForMoveFromRow sourceRow: Int, toProposedRow proposedDestinationRow: Int) -> Int // default is sourceRow
    /*optional*/ func tableView(tableView: UITableView, targetSubrowForMoveFromSubrow sourceSubrow: Int, toProposedSubrow proposedDestinationSubrow: Int, inRow row: Int) -> Int // default is sourceSubrow
}

@available(iOS 8.0, *)
public class DropDownTableViewController: UITableViewController, DropDownTableViewDataSource, DropDownTableViewDelegate {
    
    private var selectedRow: Int?
    private var numberOfSubrows = 0
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self,
                       selector: #selector(self.dropDownDeleteRows(_:)),
                       name: DropDownDeleteRowsNotification,
                       object: self.tableView)
        nc.addObserver(self,
                       selector: #selector(self.dropDownInsertRows(_:)),
                       name: DropDownInsertRowsNotification,
                       object: self.tableView)
    }
    
    deinit {
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.removeObserver(self, name: DropDownDeleteRowsNotification, object: self.tableView)
        nc.removeObserver(self, name: DropDownInsertRowsNotification, object: self.tableView)
    }
    
    override public final func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    // DropDownTableViewDataSource implementation
    
    // ****************
    public func numberOfRowsInTableView(tableView: UITableView) -> Int {
        
        return 0
    }
    
    override public final func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfRowsInTableView = self.numberOfRowsInTableView(tableView)
        
        if let selectedRow = self.selectedRow {
            
            self.numberOfSubrows = self.tableView(tableView, numberOfSubrowsInRow: selectedRow)
        } else {
            
            self.numberOfSubrows = 0
        }
        
        return numberOfRowsInTableView + self.numberOfSubrows
    }
    
    // ****************
    public func tableView(tableView: UITableView, numberOfSubrowsInRow row: Int) -> Int {
        
        return 0
    }
    
    // ****************
    public func tableView(tableView: UITableView, cellForRow row: Int, indexPath: NSIndexPath) -> UITableViewCell {
        
        fatalError("-[DropDownTableViewController tableView:cellForRow:indexPath] has not been implemented")
    }
    
    public func tableView(tableView: UITableView, cellForSubrow subrow: Int, inRow row: Int, indexPath: NSIndexPath) -> UITableViewCell {
        
        fatalError("-[DropDownTableViewController tableView:cellForRow:indexPath] has not been implemented")
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
                
                if row + 1 == self.selectedRow {
                    
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
                
                return (self.numberOfSubrows == 0) && self.tableView(tableView, canEditRow: row)
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
                
                return (self.numberOfSubrows == 0) && self.tableView(tableView, canMoveRow: row)
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
        
        if self.numberOfSubrows == 0 {
            
            let sourceRow = sourceIndexPath.row
            let destinationRow = destinationIndexPath.row
            
            self.tableView(tableView, moveRow: sourceRow, toRow: destinationRow)
            
        } else {
            
            let sourceSubrow = self.functionForIndexPath(sourceIndexPath,
                                                         functionForRow: { (row) -> Int? in
                                                            
                                                            return nil
                },
                                                         functionForSubrow: { (subrow, row) -> Int in
                                                            
                                                            return subrow
            })
            
            let destinationSubrow = self.functionForIndexPath(destinationIndexPath,
                                                         functionForRow: { (row) -> Int? in
                                                            
                                                            return nil
                },
                                                         functionForSubrow: { (subrow, row) -> Int in
                                                            
                                                            return subrow
            })
            
            self.tableView(tableView, moveSubrow: sourceSubrow!,
                           toSubrow: destinationSubrow!,
                           inRow: self.selectedRow!)
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
    
    // !!!!! NOTE: this method is not suitable for deletion and insertion any cells
    override public func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        self.functionForIndexPath(indexPath,
                                  functionForRow: { (row) -> Void in
                                    
                                    self.tableView(tableView, didEndDisplayingCell: cell, forRow: row)
                                    
            }) { (subrow, row) -> Void in
                
                self.tableView(tableView, didEndDisplayingCell: cell, forSubrow: subrow, inRow: row)
        }
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
        
        return 44//tableView.rowHeight
    }
    
    public func tableView(tableView: UITableView, heightForSubrow subrow: Int, inRow row: Int) -> CGFloat {
        
        return 44//tableView.rowHeight
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
        
        return tableView.rowHeight//tableView.estimatedRowHeight
    }
    
    public func tableView(tableView: UITableView, estimatedHeightForSubrow subrow: Int, inRow row: Int) -> CGFloat {
        
        return tableView.rowHeight//tableView.estimatedRowHeight
    }
    
    override public final func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> CGFloat in
                
                return self.tableView(tableView, estimatedHeightForRow: row)
            },
            functionForSubrow: { (subrow, row) -> CGFloat in
                
                return self.tableView(tableView, estimatedHeightForSubrow: subrow, inRow: row)
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
        
        if self.selectedRow == nil {
            
            self.selectedRow = row
            let count = self.tableView(tableView, numberOfSubrowsInRow: row)
            
            tableView.beginUpdates()
            tableView.insertSubrows(Array(0..<count),
                                    inRow: row,
                                    withRowAnimation: .Automatic)
            tableView.endUpdates()
            
            if let cell = tableView.cellForRowAtRow(row) {
                
                cell.accessoryView = self.tableView(tableView, accessoryViewForSelectedRow: row)
            }
            tableView.selectRowAtRow(row, animated: true, scrollPosition: .None)
            
        } else if self.selectedRow! == row { // subrows should be deleted from row
            
            self.selectedRow = nil
            tableView.beginUpdates()
            tableView.deleteSubrows(Array(0..<self.numberOfSubrows).reverse(),
                                    inRow: row,
                                    withRowAnimation: .Automatic)
            tableView.endUpdates()
            
            if let cell = tableView.cellForRowAtRow(row) {
                
                cell.accessoryView = self.tableView(tableView, accessoryViewForDeselectedRow: row)
            }
            tableView.deselectRowAtRow(row, animated: true)
            
        } else { // subrows should be deleted from row and inserted into (row - deletedCount)
            
            let deselectedRow = self.selectedRow!
            self.selectedRow = nil
            
            tableView.beginUpdates()
            tableView.deleteSubrows(Array(0..<self.numberOfSubrows).reverse(),
                                    inRow: deselectedRow,
                                    withRowAnimation: .Automatic)
            tableView.endUpdates()
            
            if let cell = tableView.cellForRowAtRow(deselectedRow) {
                
                if let accessoryView = self.tableView(tableView, accessoryViewForDeselectedRow: deselectedRow) {
                    
                    cell.accessoryView = accessoryView
                }
            }
            tableView.deselectRowAtRow(deselectedRow, animated: true)
            
            self.selectedRow = row
            let count = self.tableView(tableView, numberOfSubrowsInRow: row)
            
            tableView.beginUpdates()
            tableView.insertSubrows(Array(0..<count),
                                    inRow: row,
                                    withRowAnimation: .Automatic)
            tableView.endUpdates()
            
            if let cell = tableView.cellForRowAtRow(row) {
                
                cell.accessoryView = self.tableView(tableView, accessoryViewForSelectedRow: row)
            }
            tableView.selectRowAtRow(row, animated: true, scrollPosition: .None)
        }
    }
    
    override public final func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.functionForIndexPath(indexPath,
                                  functionForRow: { (row) -> Void in
                                    
                                    self.tableView(tableView, didSelectRow: row)
                                    
            }) { (subrow, row) -> Void in
                
                
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
    
    // ****************
    public func tableView(tableView: UITableView, editActionsForRow row: Int) -> [UITableViewRowAction]? {
        
        return nil
    }
    
    public func tableView(tableView: UITableView, editActionsForSubrow subrow: Int, inRow row: Int) -> [UITableViewRowAction]? {
        
        return nil
    }
    
    override public final func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        return self.functionForIndexPath(indexPath,
                                         functionForRow: { (row) -> [UITableViewRowAction]? in
                                            
                                            return self.tableView(tableView, editActionsForRow: row)
                                            
            }, functionForSubrow: { (subrow, row) -> [UITableViewRowAction]? in
                
                return self.tableView(tableView, editActionsForSubrow: subrow, inRow: row)
        })
    }
    
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
        
        if self.numberOfSubrows == 0 {
            
            let targetForRow = self.tableView(tableView, targetRowForMoveFromRow: sourceIndexPath.row,
                toProposedRow: proposedDestinationIndexPath.row)
            
            return NSIndexPath(forRow: targetForRow, inSection: 0)
            
        } else {
            
            let sourceSubrow = self.functionForIndexPath(sourceIndexPath,
                                      functionForRow: { (row) -> Int? in
                                        
                                        return nil
                                        
                }, functionForSubrow: { (subrow, row) -> Int in
                    
                    return subrow
            })
            
            let proposedSubrow = self.functionForIndexPath(proposedDestinationIndexPath,
                                                   functionForRow: { (row) -> Int? in
                                                    
                                                    return nil
                                                    
                }, functionForSubrow: { (subrow, row) -> Int in
                    
                    return subrow
            })
            
            let targetSubrow = self.tableView(tableView,
                                              targetSubrowForMoveFromSubrow: sourceSubrow!,
                                              toProposedSubrow: proposedSubrow!,
                                              inRow: self.selectedRow!)
            
            return NSIndexPath(forRow: targetSubrow + self.selectedRow! + 1, inSection: 0)
        }
    }
    
    // ****************
    public func tableView(tableView: UITableView, indentationLevelForRow row: Int) -> Int {
        
        return 0
    }
    
    public func tableView(tableView: UITableView, indentationLevelForSubrow subrow: Int, inRow row: Int) -> Int {
        
        return 0
    }
    
    override public final func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Int in
                
                self.tableView(tableView, indentationLevelForRow: row)
                
            }) { (subrow, row) -> Int in
                
                self.tableView(tableView, indentationLevelForSubrow: subrow, inRow: subrow)
        }
    }
    // ****************
    public func tableView(tableView: UITableView, shouldShowMenuForRow row: Int) -> Bool {
        
        return false
    }
    
    public func tableView(tableView: UITableView, shouldShowMenuForSubrow subrow: Int, inRow row: Int) -> Bool {
        
        return false
    }
    
    override public final func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return self.functionForIndexPath(indexPath,
                                         functionForRow: { (row) -> Bool in
                                            
                                            self.tableView(tableView, shouldShowMenuForRow: row)
                                            
        }) { (subrow, row) -> Bool in
            
            self.tableView(tableView, shouldShowMenuForSubrow: subrow, inRow: row)
        }
    }
    
    // ****************
    public func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtRow row: Int, withSender sender: AnyObject?) -> Bool {
        
        return true
    }
    
    public func tableView(tableView: UITableView, canPerformAction action: Selector, forSubrow subrow: Int, inRow row: Int, withSender sender: AnyObject?) -> Bool {
        
        return true
    }
    
    override public final func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        
        return self.functionForIndexPath(indexPath,
                                         functionForRow: { (row) -> Bool in
                                            
                                            self.tableView(tableView, canPerformAction: action, forRowAtRow: row, withSender: sender)
                                            
        }) { (subrow, row) -> Bool in
            
            self.tableView(tableView, canPerformAction: action, forSubrow: subrow, inRow: row, withSender: sender)
        }
    }
    
    // ****************
    public func tableView(tableView: UITableView, performAction action: Selector, forRowAtRow row: Int, withSender sender: AnyObject?) {
        
    }
    public func tableView(tableView: UITableView, performAction action: Selector, forSubrow subrow: Int, inRow row: Int, withSender sender: AnyObject?) {
        
    }
    
    override public final func tableView(tableView: UITableView, performAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        
        return self.functionForIndexPath(indexPath,
                                         functionForRow: { (row) -> Void in
                                            
                                            self.tableView(tableView, performAction: action, forRowAtRow: row, withSender: sender)
                                            
        }) { (subrow, row) -> Void in
            
            self.tableView(tableView, performAction: action, forSubrow: subrow, inRow: row, withSender: sender)
        }
    }
}
// 977
public extension DropDownTableViewController {
    
    public func tableView(tableView: UITableView, indexPathsForRows rows: [Int]) -> [NSIndexPath] {
        
        if let selectedRow = self.selectedRow where self.numberOfSubrows > 0 {
            
            return rows.map({ (row: Int) -> NSIndexPath in
                
                if row <= selectedRow {
                    
                    return NSIndexPath(forRow: row, inSection: 0)
                    
                } else {
                    
                    return NSIndexPath(forRow: row + self.numberOfSubrows + 1, inSection: 0)
                }
            })
            
        } else {
            
            return rows.map({ (row: Int) -> NSIndexPath in
                
                NSIndexPath(forRow: row, inSection: 0)
            })
        }
    }
    
    public func tableView(tableView: UITableView, indexPathsForSubrows subrows: [Int], inRow row: Int) -> [NSIndexPath] {
        
        if self.selectedRow == row && self.numberOfSubrows > 0 {
            
            return subrows.flatMap({ (subrow: Int) -> NSIndexPath? in
                
                if subrow < self.numberOfSubrows {
                    
                    return NSIndexPath(forRow: row + subrow + 1, inSection: 0)
                }
                return nil
            })
        }
        return []
    }
    
    public func functionForIndexPath<T>(indexPath: NSIndexPath, functionForRow: (row: Int) -> T, functionForSubrow: (subrow: Int, row: Int) -> T) -> T {
        
        let row = indexPath.row
        
        switch (self.selectedRow, self.numberOfSubrows) {
        case (let sr?, _) where row <= sr:
            fallthrough
            
        case (_, 0):
            fallthrough
            
        case (nil, _):
            return functionForRow(row: row)
            
        case (let sr?, let n) where row > sr && row <= (sr + n):
            return functionForSubrow(subrow: row - sr - 1, row: sr)
            
        default:
            return functionForRow(row: row - self.numberOfSubrows)
        }
    }
}

internal extension DropDownTableViewController {
    
    func dropDownDeleteRows(notification: NSNotification) {
        
        if let selectedRow = self.selectedRow {
            
            let rows = notification.userInfo![DropDownRowsKey] as! [Int]
            
            if rows.contains(selectedRow) {
                
                self.selectedRow = nil
                
            } else {
                
                let count = rows.countIf({ (elem: Int) -> Bool in
                    
                    elem < selectedRow
                })
                self.selectedRow! -= count
            }
        }
    }
    
    func dropDownInsertRows(notification: NSNotification) {
        
        if let selectedRow = self.selectedRow {
            
            let rows = notification.userInfo![DropDownRowsKey] as! [Int]
                
            let count = rows.countIf({ (elem: Int) -> Bool in
                    
                elem <= selectedRow
            })
            self.selectedRow! += count
        }
    }
}

private extension Array where Element: IntegerType {
    
    func countIf(@noescape predicate: (Array.Generator.Element) throws -> Bool) rethrows -> Int {
        
        return try self.reduce(0) { (index: Int, elem: Array.Generator.Element) -> Int in
            
            return index + (try predicate(elem) ? 1 : 0)
        }
    }
}
