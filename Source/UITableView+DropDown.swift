//
//  UITableView+DropDown.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 03.04.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import UIKit

// this string contant is used for notify dataSource about rows deletion
internal let DropDownDeleteRowsNotification = "DropDownDeleteRowsNotification"

// this string contant is used for notify dataSource about rows insertion
internal let DropDownInsertRowsNotification = "DropDownInsertRowsNotification"

internal let DropDownRowsKey = "DropDownRowsKey"

public extension UITableView {
    
    public func rectForRow(row: Int) -> CGRect {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForRow = dataSource.tableView(self, indexPathsForRows: [row]).first {
                
                return self.rectForRowAtIndexPath(indexPathForRow)
            }
        }
        return CGRectZero
    }
    
    // NSIndexPath(forSubrow: Int, inMainRow: Int)
    public func rectForSubrowAtIndexPath(indexPath: NSIndexPath) -> CGRect {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForSubrow = dataSource.tableView(self, indexPathsForSubrows: [indexPath.subrow], inRow: indexPath.mainrow).first {
                
                return self.rectForRowAtIndexPath(indexPathForSubrow)
            }
        }
        return CGRectZero
    }
    
    public func rowAtPoint(point: CGPoint) -> Int? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPath = self.indexPathForRowAtPoint(point) {
            
            return dataSource.functionForIndexPath(indexPath,
                                                   functionForRow: { (row: Int) -> Int in
                
                                                    return row
                },
                                                   functionForSubrow: { (subrow, row) -> Int? in
                    
                                                    return nil
            })
        }
        return nil
    }
    
    // NSIndexPath(forSubrow: Int, inMainRow: Int)
    public func indexPathForSubrowAtPoint(point: CGPoint) -> NSIndexPath? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPath = self.indexPathForRowAtPoint(point) {
            
            return dataSource.functionForIndexPath(indexPath,
                                                   functionForRow: { (row: Int) -> NSIndexPath? in
                
                                                    return nil
                },
                                                   functionForSubrow: { (subrow, row) -> NSIndexPath in
                                                    
                                                    return NSIndexPath(forSubrow: subrow, inMainRow: row)
            })
        }
        return nil
    }
    
    
    public func rowForCell(cell: UITableViewCell) -> Int? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPath = self.indexPathForCell(cell) {
            
            return dataSource.functionForIndexPath(indexPath,
                                                   functionForRow: { (row: Int) -> Int in
                                                    
                                                    return row
                },
                                                   functionForSubrow: { (subrow, row) -> Int? in
                                                    
                                                    return nil
            })
        }
        return nil
    }
    
    // NSIndexPath(forSubrow: Int, inMainRow: Int)
    public func indexPathForSubrowCell(cell: UITableViewCell) -> NSIndexPath? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPath = self.indexPathForCell(cell) {
            
            return dataSource.functionForIndexPath(indexPath,
                                                   functionForRow: { (row: Int) -> NSIndexPath? in
                                                    
                                                    return nil
                },
                                                   functionForSubrow: { (subrow, row) -> NSIndexPath in
                                                    
                                                    return NSIndexPath(forSubrow: subrow, inMainRow: row)
            })
        }
        return nil
    }
    
    public func rowsInRect(rect: CGRect) -> [Int]? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPaths = self.indexPathsForRowsInRect(rect) {
            
            return indexPaths.flatMap({ (indexPath: NSIndexPath) -> Int? in
                
                dataSource.functionForIndexPath(indexPath,
                    functionForRow: { (row) -> Int in
                        
                        return row
                    },
                    functionForSubrow: { (subrow, row) -> Int? in
                        
                        return nil
                })
            })
        }
        return nil
    }
    
    // NSIndexPath(forSubrow: Int, inMainRow: Int)
    public func indexPathsForSubrowsInRect(rect: CGRect) -> [NSIndexPath]? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPaths = self.indexPathsForRowsInRect(rect) {
            
            return indexPaths.flatMap({ (indexPath: NSIndexPath) -> NSIndexPath? in
                
                dataSource.functionForIndexPath(indexPath,
                    functionForRow: { (row) -> NSIndexPath? in
                        
                        return nil
                    },
                    functionForSubrow: { (subrow, row) -> NSIndexPath in
                        
                        return NSIndexPath(forSubrow: subrow, inMainRow: row)
                })
            })
        }
        return nil
    }
    
    public func cellForRowAtRow(row: Int) -> UITableViewCell? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForRow = dataSource.tableView(self, indexPathsForRows: [row]).first {
                
                return self.cellForRowAtIndexPath(indexPathForRow)
            }
        }
        return nil
    }
    
    // NSIndexPath(forSubrow: Int, inMainRow: Int)
    public func cellForSubrowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForSubrow = dataSource.tableView(self, indexPathsForSubrows: [indexPath.subrow], inRow: indexPath.mainrow).first {
                
                return self.cellForRowAtIndexPath(indexPathForSubrow)
            }
        }
        return nil
    }
    
    public var visibleRows: [Int]? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource,
            let indexPathsForVisibleRows = self.indexPathsForVisibleRows {
            
            return indexPathsForVisibleRows.flatMap({ (indexPath: NSIndexPath) -> Int? in
                
                dataSource.functionForIndexPath(indexPath,
                    functionForRow: { (row: Int) -> Int in
                        
                        return row
                        
                    },
                    functionForSubrow: { (subrow, row) -> Int? in
                        
                        return nil
                })
            })
        }
        return nil
    }
    
    // NSIndexPath(forSubrow: Int, inMainRow: Int)
    public var indexPathsForVisibleSubrows: [NSIndexPath]? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource,
            let indexPathsForVisibleRows = self.indexPathsForVisibleRows {
            
            return indexPathsForVisibleRows.flatMap({ (indexPath: NSIndexPath) -> NSIndexPath? in
                
                dataSource.functionForIndexPath(indexPath,
                    functionForRow: { (row: Int) -> NSIndexPath? in
                        
                        return nil
                        
                    },
                    functionForSubrow: { (subrow, row) -> NSIndexPath in
                        
                        return NSIndexPath(forSubrow: subrow, inMainRow: row)
                })
            })
        }
        return nil
    }
    
    public func scrollToRow(row: Int, atScrollPosition scrollPosition: UITableViewScrollPosition, animated: Bool) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForRow = dataSource.tableView(self, indexPathsForRows: [row]).first {
                
                self.scrollToRowAtIndexPath(indexPathForRow, atScrollPosition: scrollPosition, animated: animated)
            }
        }
    }
    
    // NSIndexPath(forSubrow: Int, inMainRow: Int)
    public func scrollToSubrowAtIndexPath(indexPath: NSIndexPath, atScrollPosition scrollPosition: UITableViewScrollPosition, animated: Bool) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {

            if let indexPathForSubrow = dataSource.tableView(self, indexPathsForSubrows: [indexPath.subrow], inRow: indexPath.mainrow).first {
                
                self.scrollToRowAtIndexPath(indexPathForSubrow, atScrollPosition: scrollPosition, animated: animated)
            }
        }
    }
    
    public func insertRowsAtRows(rows: [Int], withRowAnimation animation: UITableViewRowAnimation) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            let indexPathsForRows = dataSource.tableView(self, indexPathsForRows: rows)
                        
            // i know this is workaround. May be it will be reimplemented in future
            let nc = NSNotificationCenter.defaultCenter()
            nc.postNotificationName(DropDownInsertRowsNotification,
                                    object: self,
                                    userInfo: [DropDownRowsKey: rows])
            
            self.insertRowsAtIndexPaths(indexPathsForRows, withRowAnimation: animation)
        }
    }
    
    public func insertSubrows(subrows: [Int], inRow row: Int, withRowAnimation animation: UITableViewRowAnimation) {
        
        let indexPaths = subrows.map { (subrow: Int) -> NSIndexPath in
            
            NSIndexPath(forRow: row + subrow + 1, inSection: 0)
        }
        
        self.insertRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }
    
    public func deleteRowsAtRows(rows: [Int], withRowAnimation animation: UITableViewRowAnimation) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            let indexPathsForRows = dataSource.tableView(self, indexPathsForRows: rows)
            
            // i know this is workaround. May be it will be reimplemented in future
            let nc = NSNotificationCenter.defaultCenter()
            nc.postNotificationName(DropDownDeleteRowsNotification,
                                    object: self,
                                    userInfo: [DropDownRowsKey: rows])
            
            self.deleteRowsAtIndexPaths(indexPathsForRows, withRowAnimation: animation)
        }
    }
    
    public func deleteSubrows(subrows: [Int], inRow row: Int, withRowAnimation animation: UITableViewRowAnimation) {
        
        let indexPaths = subrows.map { (subrow: Int) -> NSIndexPath in
            
            NSIndexPath(forRow: row + subrow + 1, inSection: 0)
        }
        
        self.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: animation)
    }
    
    public func reloadRowsAtRows(rows: [Int], withRowAnimation animation: UITableViewRowAnimation) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            let indexPathsForRows = dataSource.tableView(self, indexPathsForRows: rows)
            
            self.reloadRowsAtIndexPaths(indexPathsForRows, withRowAnimation: animation)
        }
    }
    
    public func reloadSubrows(subrows: [Int], inRow row: Int, withRowAnimation animation: UITableViewRowAnimation) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            let indexPathsForSubrows = dataSource.tableView(self, indexPathsForSubrows: subrows, inRow: row)
                
            self.reloadRowsAtIndexPaths(indexPathsForSubrows, withRowAnimation: animation)
        }
    }
    
    public func moveRowAtRow(row: Int, toRow newRow: Int) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            let indexPathForRow = dataSource.tableView(self, indexPathsForRows: [row]).first!
            
            let indexPathForNewRow = dataSource.tableView(self, indexPathsForRows: [newRow]).first!
            
            self.moveRowAtIndexPath(indexPathForRow, toIndexPath: indexPathForNewRow)
        }
    }
    
    public func moveSubrow(subrow: Int, toSubrow newSubrow: Int, inRow row: Int) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            let indexPathsForSubrows = dataSource.tableView(self, indexPathsForSubrows: [subrow, newSubrow], inRow: row)
            
            let indexPathForSubrow = indexPathsForSubrows.first!
            
            let indexPathForNewSubrow = indexPathsForSubrows.last!
            
            self.moveRowAtIndexPath(indexPathForSubrow, toIndexPath: indexPathForNewSubrow)
        }
    }
    
    public var rowForSelectedRow: Int? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPathForSelectedRow = self.indexPathForSelectedRow {
            
            return dataSource.functionForIndexPath(indexPathForSelectedRow,
                                            functionForRow: { (row) -> Int in
                                                
                                                return row
                },
                                            functionForSubrow: { (subrow, row) -> Int? in
                                                
                                                return nil
            })
        }
        return nil
    }
    
    // NSIndexPath(forSubrow: Int, inMainRow: Int)
    public var indexPathForSelectedSubrow: NSIndexPath? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPathForSelectedRow = self.indexPathForSelectedRow {
            
            return dataSource.functionForIndexPath(indexPathForSelectedRow,
                                            functionForRow: { (row) -> NSIndexPath? in
                                                
                                                return nil
                },
                                            functionForSubrow: { (subrow, row) -> NSIndexPath in
                                                
                                                return NSIndexPath(forSubrow: subrow, inMainRow: row)
            })
        }
        return nil
    }
    
    public var rowsForSelectedRows: [Int]? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPathsForSelectedRows = self.indexPathsForSelectedRows {
            
            return indexPathsForSelectedRows.flatMap({ (indexPath: NSIndexPath) -> Int? in
                
                dataSource.functionForIndexPath(indexPath,
                    functionForRow: { (row) -> Int in
                        
                        return row
                        
                    },
                    functionForSubrow: { (subrow, row) -> Int? in
                        
                        return nil
                })
            })
        }
        
        return nil
    }
    
    // NSIndexPath(forSubrow: Int, inMainRow: Int)
    public var indexPathsForSelectedSubrows: [NSIndexPath]? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPathsForSelectedRows = self.indexPathsForSelectedRows {
            
            return indexPathsForSelectedRows.flatMap({ (indexPath: NSIndexPath) -> NSIndexPath? in
                
                dataSource.functionForIndexPath(indexPath,
                    functionForRow: { (row) -> NSIndexPath? in
                        
                        return nil
                        
                    },
                    functionForSubrow: { (subrow, row) -> NSIndexPath in
                        
                        return NSIndexPath(forSubrow: subrow, inMainRow: row)
                })
            })
        }
        return nil
    }
    
    public func selectRowAtRow(row: Int?, animated: Bool, scrollPosition: UITableViewScrollPosition) {
        
        if let row = row, let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForRow = dataSource.tableView(self, indexPathsForRows: [row]).first {
                
                self.selectRowAtIndexPath(indexPathForRow, animated: animated, scrollPosition: scrollPosition)
            }
            
        } else {
            
            self.selectRowAtIndexPath(nil, animated: animated, scrollPosition: scrollPosition)
        }
    }
    
    // NSIndexPath(forSubrow: Int, inMainRow: Int)
    public func selectSubrowAtIndexPath(indexPath: NSIndexPath?, animated: Bool, scrollPosition: UITableViewScrollPosition) {
        
        if let indexPath = indexPath, let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForSubrow = dataSource.tableView(self, indexPathsForSubrows: [indexPath.subrow], inRow: indexPath.mainrow).first {
                
                self.selectRowAtIndexPath(indexPathForSubrow, animated: animated, scrollPosition: scrollPosition)
            }
            
        } else {
            
            self.selectRowAtIndexPath(nil, animated: animated, scrollPosition: scrollPosition)
        }
    }
    
    public func deselectRowAtRow(row: Int, animated: Bool) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForRow = dataSource.tableView(self, indexPathsForRows: [row]).first {
                
                self.deselectRowAtIndexPath(indexPathForRow, animated: animated)
            }
        }
    }
    
    // NSIndexPath(forSubrow: Int, inMainRow: Int)
    public func deselectSubrowAtIndexPath(indexPath: NSIndexPath, animated: Bool) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForSubrow = dataSource.tableView(self, indexPathsForSubrows: [indexPath.subrow], inRow: indexPath.mainrow).first {
                
                self.deselectRowAtIndexPath(indexPathForSubrow, animated: animated)
            }
        }
    }
}