//
//  UITableView+DropDown.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 03.04.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import UIKit

public extension UITableView {
    
    public func rectForRow(_ row: Int) -> CGRect {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForRow = dataSource.tableView(self, indexPathsForRows: [row]).first {
                
                return self.rectForRow(at: indexPathForRow)
            }
        }
        return CGRect.zero
    }
    
    // NSIndexPath(forSubrow: Int, inMainRow: Int)
    public func rectForSubrowAtIndexPath(_ indexPath: IndexPath) -> CGRect {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForSubrow = dataSource.tableView(self, indexPathsForSubrows: [indexPath.subrow], inRow: indexPath.mainrow).first {
                
                return self.rectForRow(at: indexPathForSubrow)
            }
        }
        return CGRect.zero
    }
    
    public func rowAtPoint(_ point: CGPoint) -> Int? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPath = self.indexPathForRow(at: point) {
            
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
    public func indexPathForSubrowAtPoint(_ point: CGPoint) -> IndexPath? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPath = self.indexPathForRow(at: point) {
            
            return dataSource.functionForIndexPath(indexPath,
                                                   functionForRow: { (row: Int) -> IndexPath? in
                
                                                    return nil
                },
                                                   functionForSubrow: { (subrow, row) -> IndexPath in
                                                    
                                                    return IndexPath(forSubrow: subrow, inMainRow: row)
            })
        }
        return nil
    }
    
    
    public func rowForCell(_ cell: UITableViewCell) -> Int? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPath = self.indexPath(for: cell) {
            
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
    public func indexPathForSubrowCell(_ cell: UITableViewCell) -> IndexPath? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPath = self.indexPath(for: cell) {
            
            return dataSource.functionForIndexPath(indexPath,
                                                   functionForRow: { (row: Int) -> IndexPath? in
                                                    
                                                    return nil
                },
                                                   functionForSubrow: { (subrow, row) -> IndexPath in
                                                    
                                                    return IndexPath(forSubrow: subrow, inMainRow: row)
            })
        }
        return nil
    }
    
    public func rowsInRect(_ rect: CGRect) -> [Int]? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPaths = self.indexPathsForRows(in: rect) {
            
            return indexPaths.flatMap({ (indexPath: IndexPath) -> Int? in
                
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
    public func indexPathsForSubrowsInRect(_ rect: CGRect) -> [IndexPath]? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPaths = self.indexPathsForRows(in: rect) {
            
            return indexPaths.flatMap({ (indexPath: IndexPath) -> IndexPath? in
                
                dataSource.functionForIndexPath(indexPath,
                    functionForRow: { (row) -> IndexPath? in
                        
                        return nil
                    },
                    functionForSubrow: { (subrow, row) -> IndexPath in
                        
                        return IndexPath(forSubrow: subrow, inMainRow: row)
                })
            })
        }
        return nil
    }
    
    public func cellForRowAtRow(_ row: Int) -> UITableViewCell? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForRow = dataSource.tableView(self, indexPathsForRows: [row]).first {
                
                return self.cellForRow(at: indexPathForRow)
            }
        }
        return nil
    }
    
    // NSIndexPath(forSubrow: Int, inMainRow: Int)
    public func cellForSubrowAtIndexPath(_ indexPath: IndexPath) -> UITableViewCell? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForSubrow = dataSource.tableView(self, indexPathsForSubrows: [indexPath.subrow], inRow: indexPath.mainrow).first {
                
                return self.cellForRow(at: indexPathForSubrow)
            }
        }
        return nil
    }
    
    public var visibleRows: [Int]? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource,
            let indexPathsForVisibleRows = self.indexPathsForVisibleRows {
            
            return indexPathsForVisibleRows.flatMap({ (indexPath: IndexPath) -> Int? in
                
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
    public var indexPathsForVisibleSubrows: [IndexPath]? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource,
            let indexPathsForVisibleRows = self.indexPathsForVisibleRows {
            
            return indexPathsForVisibleRows.flatMap({ (indexPath: IndexPath) -> IndexPath? in
                
                dataSource.functionForIndexPath(indexPath,
                    functionForRow: { (row: Int) -> IndexPath? in
                        
                        return nil
                        
                    },
                    functionForSubrow: { (subrow, row) -> IndexPath in
                        
                        return IndexPath(forSubrow: subrow, inMainRow: row)
                })
            })
        }
        return nil
    }
    
    public func scrollToRow(_ row: Int, atScrollPosition scrollPosition: UITableViewScrollPosition, animated: Bool) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForRow = dataSource.tableView(self, indexPathsForRows: [row]).first {
                
                self.scrollToRow(at: indexPathForRow, at: scrollPosition, animated: animated)
            }
        }
    }
    
    // NSIndexPath(forSubrow: Int, inMainRow: Int)
    public func scrollToSubrowAtIndexPath(_ indexPath: IndexPath, atScrollPosition scrollPosition: UITableViewScrollPosition, animated: Bool) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {

            if let indexPathForSubrow = dataSource.tableView(self, indexPathsForSubrows: [indexPath.subrow], inRow: indexPath.mainrow).first {
                
                self.scrollToRow(at: indexPathForSubrow, at: scrollPosition, animated: animated)
            }
        }
    }
    
    public func insertRowsAtRows(_ rows: [Int], withRowAnimation animation: UITableViewRowAnimation) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            let indexPathsForRows = dataSource.tableView(self, indexPathsForRows: rows)
            
            dataSource.dropDownInsertRows(rows)
            
            self.insertRows(at: indexPathsForRows, with: animation)
        }
    }
    
    public func insertSubrows(_ subrows: [Int], inRow row: Int, withRowAnimation animation: UITableViewRowAnimation) {
        
        let indexPaths = subrows.map { (subrow: Int) -> IndexPath in
            
            IndexPath(row: row + subrow + 1, section: 0)
        }
        
        self.insertRows(at: indexPaths, with: animation)
    }
    
    public func deleteRowsAtRows(_ rows: [Int], withRowAnimation animation: UITableViewRowAnimation) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            let indexPathsForRows = dataSource.tableView(self, indexPathsForRows: rows)
            
            dataSource.dropDownDeleteRows(rows)
            
            self.deleteRows(at: indexPathsForRows, with: animation)
        }
    }
    
    public func deleteSubrows(_ subrows: [Int], inRow row: Int, withRowAnimation animation: UITableViewRowAnimation) {
        
        let indexPaths = subrows.map { (subrow: Int) -> IndexPath in
            
            IndexPath(row: row + subrow + 1, section: 0)
        }
        
        self.deleteRows(at: indexPaths, with: animation)
    }
    
    public func reloadRowsAtRows(_ rows: [Int], withRowAnimation animation: UITableViewRowAnimation) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            let indexPathsForRows = dataSource.tableView(self, indexPathsForRows: rows)
            
            self.reloadRows(at: indexPathsForRows, with: animation)
        }
    }
    
    public func reloadSubrows(_ subrows: [Int], inRow row: Int, withRowAnimation animation: UITableViewRowAnimation) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            let indexPathsForSubrows = dataSource.tableView(self, indexPathsForSubrows: subrows, inRow: row)
                
            self.reloadRows(at: indexPathsForSubrows, with: animation)
        }
    }
    
    public func moveRowAtRow(_ row: Int, toRow newRow: Int) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            let indexPathForRow = dataSource.tableView(self, indexPathsForRows: [row]).first!
            
            let indexPathForNewRow = dataSource.tableView(self, indexPathsForRows: [newRow]).first!
            
            self.moveRow(at: indexPathForRow, to: indexPathForNewRow)
        }
    }
    
    public func moveSubrow(_ subrow: Int, toSubrow newSubrow: Int, inRow row: Int) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            let indexPathsForSubrows = dataSource.tableView(self, indexPathsForSubrows: [subrow, newSubrow], inRow: row)
            
            let indexPathForSubrow = indexPathsForSubrows.first!
            
            let indexPathForNewSubrow = indexPathsForSubrows.last!
            
            self.moveRow(at: indexPathForSubrow, to: indexPathForNewSubrow)
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
    public var indexPathForSelectedSubrow: IndexPath? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPathForSelectedRow = self.indexPathForSelectedRow {
            
            return dataSource.functionForIndexPath(indexPathForSelectedRow,
                                            functionForRow: { (row) -> IndexPath? in
                                                
                                                return nil
                },
                                            functionForSubrow: { (subrow, row) -> IndexPath in
                                                
                                                return IndexPath(forSubrow: subrow, inMainRow: row)
            })
        }
        return nil
    }
    
    public var rowsForSelectedRows: [Int]? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPathsForSelectedRows = self.indexPathsForSelectedRows {
            
            return indexPathsForSelectedRows.flatMap({ (indexPath: IndexPath) -> Int? in
                
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
    public var indexPathsForSelectedSubrows: [IndexPath]? {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource, let indexPathsForSelectedRows = self.indexPathsForSelectedRows {
            
            return indexPathsForSelectedRows.flatMap({ (indexPath: IndexPath) -> IndexPath? in
                
                dataSource.functionForIndexPath(indexPath,
                    functionForRow: { (row) -> IndexPath? in
                        
                        return nil
                        
                    },
                    functionForSubrow: { (subrow, row) -> IndexPath in
                        
                        return IndexPath(forSubrow: subrow, inMainRow: row)
                })
            })
        }
        return nil
    }
    
    public func selectRowAtRow(_ row: Int?, animated: Bool, scrollPosition: UITableViewScrollPosition) {
        
        if let row = row, let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForRow = dataSource.tableView(self, indexPathsForRows: [row]).first {
                
                self.selectRow(at: indexPathForRow, animated: animated, scrollPosition: scrollPosition)
            }
            
        } else {
            
            self.selectRow(at: nil, animated: animated, scrollPosition: scrollPosition)
        }
    }
    
    // NSIndexPath(forSubrow: Int, inMainRow: Int)
    public func selectSubrowAtIndexPath(_ indexPath: IndexPath?, animated: Bool, scrollPosition: UITableViewScrollPosition) {
        
        if let indexPath = indexPath, let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForSubrow = dataSource.tableView(self, indexPathsForSubrows: [indexPath.subrow], inRow: indexPath.mainrow).first {
                
                self.selectRow(at: indexPathForSubrow, animated: animated, scrollPosition: scrollPosition)
            }
            
        } else {
            
            self.selectRow(at: nil, animated: animated, scrollPosition: scrollPosition)
        }
    }
    
    public func deselectRowAtRow(_ row: Int, animated: Bool) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForRow = dataSource.tableView(self, indexPathsForRows: [row]).first {
                
                self.deselectRow(at: indexPathForRow, animated: animated)
            }
        }
    }
    
    // NSIndexPath(forSubrow: Int, inMainRow: Int)
    public func deselectSubrowAtIndexPath(_ indexPath: IndexPath, animated: Bool) {
        
        if let dataSource = self.dataSource as? DropDownTableViewDataSource {
            
            if let indexPathForSubrow = dataSource.tableView(self, indexPathsForSubrows: [indexPath.subrow], inRow: indexPath.mainrow).first {
                
                self.deselectRow(at: indexPathForSubrow, animated: animated)
            }
        }
    }
}
