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
// row1 \/       | -> one section in UITableView
// row2 \/      -/
//
//
//
//
// row0 /\      -\
//    subrow0     \
//    subrow1     |
//    subrow2     | -> one section in UITableView
//    subrow3     |
// row1 \/        /
// row2 \/      -/
//
////////////////////////////////////////////////


@available(iOS 8.0, *)
open class DropDownTableViewController: UITableViewController {
    
    fileprivate var selectedRow: Int?
    fileprivate var numberOfSubrows = 0
    
    override public final func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    // DropDownTableViewDataSource implementation
    
    open func numberOfRows(in tableView: UITableView) -> Int {
        
        return 0
    }
    
    override public final func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfRows = self.numberOfRows(in: tableView)
            
        if let selectedRow = self.selectedRow {
                
            self.numberOfSubrows = self.tableView(tableView, numberOfSubrowsInRow: selectedRow)
            
        } else {
                
            self.numberOfSubrows = 0
        }
                
        return numberOfRows + self.numberOfSubrows
    }
    
    open func tableView(_ tableView: UITableView, cellForRow row: Int, indexPath: IndexPath) -> UITableViewCell {
        
        fatalError("-[DropDownTableViewController tableView:cellForRow:indexPath] has not been implemented")
    }
    
    open func tableView(_ tableView: UITableView, cellForSubrow subrow: Int, inRow row: Int, indexPath: IndexPath) -> UITableViewCell {
        
        fatalError("-[DropDownTableViewController tableView:cellForRow:indexPath] has not been implemented")
    }
    
    override public final func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return self.functionForIndexPath(indexPath,
                                         functionForRow: { (row) -> UITableViewCell in
                                            
                                            let cellForRow = self.tableView(tableView, cellForRow: row, indexPath: indexPath)
                                            
                                            if let accessoryViewForSelectedRow = self.tableView(tableView, accessoryViewForSelectedRow: row) , row == self.selectedRow {
                                                
                                                cellForRow.accessoryView = accessoryViewForSelectedRow
                                                
                                            } else if let accessoryViewForDeselectedRow = self.tableView(tableView, accessoryViewForDeselectedRow: row) {
                                                
                                                cellForRow.accessoryView = accessoryViewForDeselectedRow
                                            }
                                            
                                            return cellForRow
                                            
        }) { (subrow, row) -> UITableViewCell in
            
            return self.tableView(tableView, cellForSubrow: subrow, inRow: row, indexPath: indexPath)
        }
    }
    
    override public final func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.titleForHeader(in: tableView)
    }
    
    override public final func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return self.titleForFooter(in: tableView)
    }
    
    override public final func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Bool in
                
                return (self.numberOfSubrows == 0) && self.tableView(tableView, canEditRow: row)
            },
            functionForSubrow: { (subrow, row) -> Bool in
                
                return self.tableView(tableView, canEditSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
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
    
    override public final func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Void in
                
                self.tableView(tableView, commitEditingStyle: editingStyle, forRow: row)
                
            }) { (subrow, row) -> Void in
                
                self.tableView(tableView, commitEditingStyle: editingStyle, forSubrow: subrow, inRow: row)
        }
    }
    
    override public final func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if self.numberOfSubrows == 0 {
            
            let sourceRow = sourceIndexPath.row
            let destinationRow = destinationIndexPath.row
            
            self.tableView(tableView, moveRow: sourceRow, to: destinationRow)
            
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
                           to: destinationSubrow!,
                           inRow: self.selectedRow!)
        }
    }
    
    // DropDownTableViewDelegate implementation
    
    override public final func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Void in
                
                self.tableView(tableView, willDisplayCell: cell, forRow: row)
                
            }) { (subrow, row) -> Void in
                
                self.tableView(tableView, willDisplayCell: cell, forSubrow: subrow, inRow: row)
        }
    }
    
    override public final func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        self.tableView(tableView, willDisplayHeaderView: view)
    }
    
    override public final func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        self.tableView(tableView, willDisplayFooterView: view)
    }
    
    // !!!!! NOTE: this method is not suitable for deletion and insertion any cells
    override open func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        self.functionForIndexPath(indexPath,
                                  functionForRow: { (row) -> Void in
                                    
                                    self.tableView(tableView, didEndDisplayingCell: cell, forRow: row)
                                    
            }) { (subrow, row) -> Void in
                
                self.tableView(tableView, didEndDisplayingCell: cell, forSubrow: subrow, inRow: row)
        }
    }
    
    override public final func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        
        self.tableView(tableView, didEndDisplayingHeaderView: view)
    }
    
    override public final func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        
        self.tableView(tableView, didEndDisplayingFooterView: view)
    }
    
    override public final func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> CGFloat in
                
                return self.tableView(tableView, heightForRow: row)
                
            },
            functionForSubrow: { (subrow, row) -> CGFloat in
                
                return self.tableView(tableView, heightForSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return self.heightForHeader(in: tableView)
    }
    
    override public final func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return self.heightForFooter(in: tableView)
    }
    
    override public final func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> CGFloat in
                
                return self.tableView(tableView, estimatedHeightForRow: row)
            },
            functionForSubrow: { (subrow, row) -> CGFloat in
                
                return self.tableView(tableView, estimatedHeightForSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        
        return self.estimatedHeightForHeader(in: tableView)
    }
    
    override public final func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        
        return self.estimatedHeightForFooter(in: tableView)
    }
    
    override public final func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return self.viewForHeader(in: tableView)
    }
    
    override public final func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return self.viewForFooter(in: tableView)
    }
    
    override public final func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Void in
                
                self.tableView(tableView, accessoryButtonTappedForRow: row)
                
            }) { (subrow, row) -> Void in
                
            self.tableView(tableView, accessoryButtonTappedForSubrow: subrow, inRow: row)
        }
    }
    
    override public final func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Bool in
                
                return self.tableView(tableView, shouldHighlightRow: row)
                
            }, functionForSubrow: { (subrow, row) -> Bool in
                
                return self.tableView(tableView, shouldHighlightSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Void in
                
                self.tableView(tableView, didHighlightRow: row)
                
            }) { (subrow, row) -> Void in
                
                self.tableView(tableView, didHighlightSubrow: subrow, inRow: row)
        }
    }
    
    override public final func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
        self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Void in
                
                self.tableView(tableView, didUnhighlightRow: row)
                
            }) { (subrow, row) -> Void in
                
                self.tableView(tableView, didUnhighlightSubrow: subrow, inRow: row)
        }
    }
    
    override public final func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> IndexPath? in
                
                return indexPath
                
            },
            functionForSubrow: { (subrow, row) -> IndexPath? in
                
                return nil
        })
    }
    
    override public final func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        
        return indexPath
    }
    
    open func tableView(_ tableView: UITableView, didSelectRow row: Int) {
        
        if self.selectedRow == nil {
            
            self.selectedRow = row
            
            let count = self.tableView(tableView, numberOfSubrowsInRow: row)
            
            tableView.beginUpdates()
            tableView.insertSubrows(Array(0..<count),
                                    in: row,
                                    with: .automatic)
            tableView.endUpdates()
            
            if let cell = tableView.cellForRow(at: row) {
                
                cell.accessoryView = self.tableView(tableView, accessoryViewForSelectedRow: row)
            }
            tableView.selectRowAt(row, animated: true, scrollPosition: .none)
            
        } else if self.selectedRow! == row { // subrows should be deleted from row
            
            self.selectedRow = nil
            tableView.beginUpdates()
            tableView.deleteSubrows(Array(0..<self.numberOfSubrows).reversed(),
                                    in: row,
                                    with: .automatic)
            tableView.endUpdates()
            
            if let cell = tableView.cellForRow(at: row) {
                
                cell.accessoryView = self.tableView(tableView, accessoryViewForDeselectedRow: row)
            }
            tableView.deselectRow(at: row, animated: true)
            
        } else { // subrows should be deleted from row and inserted into (row - deletedCount)
            
            let deselectedRow = self.selectedRow!
            self.selectedRow = nil
            
            tableView.beginUpdates()
            tableView.deleteSubrows(Array(0..<self.numberOfSubrows).reversed(),
                                    in: deselectedRow,
                                    with: .automatic)
            tableView.endUpdates()
            
            if let cell = tableView.cellForRow(at: deselectedRow) {
                
                if let accessoryView = self.tableView(tableView, accessoryViewForDeselectedRow: deselectedRow) {
                    
                    cell.accessoryView = accessoryView
                }
            }
            tableView.deselectRow(at: deselectedRow, animated: true)
            
            self.selectedRow = row
            let count = self.tableView(tableView, numberOfSubrowsInRow: row)
            
            tableView.beginUpdates()
            tableView.insertSubrows(Array(0..<count),
                                    in: row,
                                    with: .automatic)
            tableView.endUpdates()
            
            if let cell = tableView.cellForRow(at: row) {
                
                cell.accessoryView = self.tableView(tableView, accessoryViewForSelectedRow: row)
            }
            tableView.selectRowAt(row, animated: true, scrollPosition: .none)
        }
    }
    
    override public final func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.functionForIndexPath(indexPath,
                                  functionForRow: { (row) -> Void in
                                    
                                    self.tableView(tableView, didSelectRow: row)
                                    
            }) { (subrow, row) -> Void in
                
                
        }
    }
    
    override public final func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Void in
                
                self.tableView(tableView, didDeselectRow: row)
                
            }) { (subrow, row) -> Void in
                
                
        }
    }
    
    override public final func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> UITableViewCellEditingStyle in
                
                self.tableView(tableView, editingStyleForRow: row)
                
            }) { (subrow, row) -> UITableViewCellEditingStyle in
                
                self.tableView(tableView, editingStyleForSubrow: subrow, inRow: row)
        }
    }
    
    // ****************
    /*open override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
    }*/
    
    override public final func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        return self.functionForIndexPath(indexPath,
                                         functionForRow: { (row) -> [UITableViewRowAction]? in
                                            
                                            return self.tableView(tableView, editActionsForRow: row)
                                            
            }, functionForSubrow: { (subrow, row) -> [UITableViewRowAction]? in
                
                return self.tableView(tableView, editActionsForSubrow: subrow, inRow: row)
        })
    }
    
    override public final func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Bool in
                
                self.tableView(tableView, shouldIndentWhileEditingRow: row)
                
            }) { (subrow, row) -> Bool in
                
                self.tableView(tableView, shouldIndentWhileEditingSubrow: subrow, inRow: row)
        }
    }
    
    override public final func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        
        self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Void in
                
                self.tableView(tableView, willBeginEditingRow: row)
                
            }) { (subrow, row) -> Void in
                
                self.tableView(tableView, willBeginEditingSubrow: subrow, inRow: row)
        }
    }
    
    override public final func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        
        self.functionForIndexPath(indexPath!,
            functionForRow: { (row) -> Void in
                
                self.tableView(tableView, didEndEditingRow: row)
                
            }) { (subrow, row) -> Void in
                
                self.tableView(tableView, didEndEditingSubrow: subrow, inRow: row)
        }
    }
    
    override public final func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        
        if self.numberOfSubrows == 0 {
            
            let targetForRow = self.tableView(tableView, targetRowForMoveFromRow: sourceIndexPath.row,
                to: proposedDestinationIndexPath.row)
            
            return IndexPath(row: targetForRow, section: 0)
            
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
            
            if proposedSubrow != nil && sourceSubrow != nil {
                
                let targetSubrow = self.tableView(tableView,
                                                  targetSubrowForMoveFromSubrow: sourceSubrow!,
                                                  to: proposedSubrow!,
                                                  inRow: self.selectedRow!)
                
                return IndexPath(row: targetSubrow + self.selectedRow! + 1, section: 0)
                
            } else {
                
                return sourceIndexPath
            }
        }
    }
    
    override public final func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        
        return self.functionForIndexPath(indexPath,
            functionForRow: { (row) -> Int in
                
                self.tableView(tableView, indentationLevelForRow: row)
                
            }) { (subrow, row) -> Int in
                
                self.tableView(tableView, indentationLevelForSubrow: subrow, inRow: subrow)
        }
    }
    
    override public final func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        
        return self.functionForIndexPath(indexPath,
                                         functionForRow: { (row) -> Bool in
                                            
                                            self.tableView(tableView, shouldShowMenuForRow: row)
                                            
        }) { (subrow, row) -> Bool in
            
            self.tableView(tableView, shouldShowMenuForSubrow: subrow, inRow: row)
        }
    }
    
    override public final func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        
        return self.functionForIndexPath(indexPath,
                                         functionForRow: { (row) -> Bool in
                                            
                                            return self.tableView(tableView, canPerformAction: action, forRowAtRow: row, withSender: sender)
                                            
        }) { (subrow, row) -> Bool in
            
            self.tableView(tableView, canPerformAction: action, forSubrow: subrow, inRow: row, withSender: sender)
        }
    }
    
    override public final func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        
        return self.functionForIndexPath(indexPath,
                                         functionForRow: { (row) -> Void in
                                            
                                            self.tableView(tableView, performAction: action, forRowAtRow: row, withSender: sender)
                                            
        }) { (subrow, row) -> Void in
            
            self.tableView(tableView, performAction: action, forSubrow: subrow, inRow: row, withSender: sender)
        }
    }
    
    
    open func tableView(_ tableView: UITableView, indexPathsForRows rows: [Int]) -> [IndexPath] {
        
        if let selectedRow = self.selectedRow , self.numberOfSubrows > 0 {
            
            return rows.map({ (row: Int) -> IndexPath in
                
                if row <= selectedRow {
                    
                    return IndexPath(row: row, section: 0)
                    
                } else {
                    
                    return IndexPath(row: row + self.numberOfSubrows + 1, section: 0)
                }
            })
            
        } else {
            
            return rows.map({ (row: Int) -> IndexPath in
                
                IndexPath(row: row, section: 0)
            })
        }
    }
    
    open func tableView(_ tableView: UITableView, indexPathsForSubrows subrows: [Int], inRow row: Int) -> [IndexPath] {
        
        if self.selectedRow == row && self.numberOfSubrows > 0 {
            
            return subrows.flatMap({ (subrow: Int) -> IndexPath? in
                
                if subrow < self.numberOfSubrows {
                    
                    return IndexPath(row: row + subrow + 1, section: 0)
                }
                return nil
            })
        }
        return []
    }
    
    open func functionForIndexPath<T>(_ indexPath: IndexPath,
                                   functionForRow: (_ row: Int) -> T,
                                   functionForSubrow: (_ subrow: Int, _ row: Int) -> T) -> T {
        
        let row = indexPath.row
        
        switch (self.selectedRow, self.numberOfSubrows) {
        case (let sr?, _) where row <= sr:
            fallthrough
            
        case (_, 0):
            fallthrough
            
        case (nil, _):
            return functionForRow(row)
            
        case (let sr?, let n) where row > sr && row <= (sr + n):
            return functionForSubrow(row - sr - 1, sr)
            
        default:
            return functionForRow(row - self.numberOfSubrows)
        }
    }
    
    open func dropDownDeleteRows(_ rows: [Int], in tableView: UITableView) {
        
        if let selectedRow = self.selectedRow {
            
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
    
    open func dropDownInsertRows(_ rows: [Int], in tableView: UITableView) {
        
        if let selectedRow = self.selectedRow {
            
            let count = rows.countIf({ (elem: Int) -> Bool in
                
                elem <= selectedRow
            })
            self.selectedRow! += count
        }
    }
}

private extension Array where Element: Integer {
    
    func countIf(_ predicate: (Array.Iterator.Element) throws -> Bool) rethrows -> Int {
        
        return try self.reduce(0) { (index: Int, elem: Array.Iterator.Element) -> Int in
            
            return index + (try predicate(elem) ? 1 : 0)
        }
    }
}
