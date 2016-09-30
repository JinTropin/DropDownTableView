//
//  UITableView+DropDown.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 03.04.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import UIKit

public extension UITableView {
    
    public var dropDownDelegate: DropDownTableViewDelegate? {
        
        return self.delegate as? DropDownTableViewDelegate
    }
    
    public var dropDownDataSource: DropDownTableViewDataSource? {
        
        return self.dataSource as? DropDownTableViewDataSource
    }
    
    public func rectForRow(_ row: Int) -> CGRect {
        
        if let indexPathForRow = self.dropDownDataSource?.tableView(self, indexPathsForRows: [row]).first {
            
            return self.rectForRow(at: indexPathForRow)
        }
        
        return CGRect.zero
    }
    
    // IndexPath(forSubrow: Int, inMainRow: Int)
    public func rectForSubrow(at indexPath: IndexPath) -> CGRect {
        
        if let indexPathForSubrow = self.dropDownDataSource?.tableView(self, indexPathsForSubrows: [indexPath.subrow], inRow: indexPath.mainrow).first {
            
            return self.rectForRow(at: indexPathForSubrow)
        }
        return CGRect.zero
    }
    
    public func row(at point: CGPoint) -> Int? {
        
        if let indexPath = self.indexPathForRow(at: point) {
            
            return self.dropDownDataSource?.functionForIndexPath(indexPath, functionForRow: { (row: Int) -> Int in
                
                return row
                
                }, functionForSubrow: { (subrow, row) -> Int? in
                    
                    return nil
            })
        }
        
        return nil
    }
    
    // IndexPath(forSubrow: Int, inMainRow: Int)
    public func indexPathForSubrow(at point: CGPoint) -> IndexPath? {
        
        if let indexPath = self.indexPathForRow(at: point) {
            
            return self.dropDownDataSource?.functionForIndexPath(indexPath,
                                                   functionForRow: { (row: Int) -> IndexPath? in
                                                    
                                                    return nil
                },
                                                   functionForSubrow: { (subrow, row) -> IndexPath in
                                                    
                                                    return IndexPath(forSubrow: subrow, inMainRow: row)
            })
        }
        
        return nil
    }
    
    public func row(for cell: UITableViewCell) -> Int? {
        
        if let indexPath = self.indexPath(for: cell) {
            
            return self.dropDownDataSource?.functionForIndexPath(indexPath,
                                                   functionForRow: { (row: Int) -> Int in
                                                    
                                                    return row
                },
                                                   functionForSubrow: { (subrow, row) -> Int? in
                                                    
                                                    return nil
            })
        }
        return nil
    }
    
    // IndexPath(forSubrow: Int, inMainRow: Int)
    public func indexPathForSubrowCell(_ cell: UITableViewCell) -> IndexPath? {
        
        if let indexPath = self.indexPath(for: cell) {
            
            return self.dropDownDataSource?.functionForIndexPath(indexPath,
                                                   functionForRow: { (row: Int) -> IndexPath? in
                                                    
                                                    return nil
                },
                                                   functionForSubrow: { (subrow, row) -> IndexPath in
                                                    
                                                    return IndexPath(forSubrow: subrow, inMainRow: row)
            })
        }
        return nil
    }
    
    public func rows(in rect: CGRect) -> [Int]? {
        
        if let indexPaths = self.indexPathsForRows(in: rect) {
            
            return indexPaths.flatMap({ (indexPath: IndexPath) -> Int? in
                
                self.dropDownDataSource?.functionForIndexPath(indexPath,
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
    
    // IndexPath(forSubrow: Int, inMainRow: Int)
    public func indexPathsForSubrows(in rect: CGRect) -> [IndexPath]? {
        
        if let indexPaths = self.indexPathsForRows(in: rect) {
            
            return indexPaths.flatMap({ (indexPath: IndexPath) -> IndexPath? in
                
                self.dropDownDataSource?.functionForIndexPath(indexPath,
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
    
    public func cellForRow(at row: Int) -> UITableViewCell? {
        
        if let indexPathForRow = self.dropDownDataSource?.tableView(self, indexPathsForRows: [row]).first {
            
            return self.cellForRow(at: indexPathForRow)
        }
        return nil
    }
    
    // IndexPath(forSubrow: Int, inMainRow: Int)
    public func cellForSubrow(at indexPath: IndexPath) -> UITableViewCell? {
        
        if let indexPathForSubrow = self.dropDownDataSource?.tableView(self, indexPathsForSubrows: [indexPath.subrow], inRow: indexPath.mainrow).first {
            
            return self.cellForRow(at: indexPathForSubrow)
        }
        return nil
    }
    
    public var visibleRows: [Int]? {
        
        return self.indexPathsForVisibleRows?.flatMap({ (indexPath: IndexPath) -> Int? in
            
            self.dropDownDataSource?.functionForIndexPath(indexPath,
                                                          
                                                          functionForRow: { (row: Int) -> Int in
                        
                        return row
                        
                    },
                    functionForSubrow: { (subrow, row) -> Int? in
                        
                        return nil
            })
        })
    }
    
    // IndexPath(forSubrow: Int, inMainRow: Int)
    public var indexPathsForVisibleSubrows: [IndexPath]? {
        
        return self.indexPathsForVisibleRows?.flatMap({ (indexPath: IndexPath) -> IndexPath? in
                
            self.dropDownDataSource?.functionForIndexPath(indexPath,
                    functionForRow: { (row: Int) -> IndexPath? in
                        
                        return nil
                        
                    },
                    functionForSubrow: { (subrow, row) -> IndexPath in
                        
                        return IndexPath(forSubrow: subrow, inMainRow: row)
                })
            })
    }
    
    public func scrollToRow(at row: Int, at scrollPosition: UITableViewScrollPosition, animated: Bool) {
        
        if let indexPathForRow = self.dropDownDataSource?.tableView(self, indexPathsForRows: [row]).first {
            
            self.scrollToRow(at: indexPathForRow, at: scrollPosition, animated: animated)
        }
    }
    
    // IndexPath(forSubrow: Int, inMainRow: Int)
    public func scrollToSubrow(at indexPath: IndexPath, at scrollPosition: UITableViewScrollPosition, animated: Bool) {
        
        if let indexPathForSubrow = self.dropDownDataSource?.tableView(self, indexPathsForSubrows: [indexPath.subrow], inRow: indexPath.mainrow).first {
            
            self.scrollToRow(at: indexPathForSubrow, at: scrollPosition, animated: animated)
        }
    }
    
    public func insertRows(at rows: [Int], with animation: UITableViewRowAnimation) {
        
        if let indexPathsForRows = self.dropDownDataSource?.tableView(self, indexPathsForRows: rows) {
        
            self.dropDownDataSource?.dropDownInsertRows(rows, in: self)
            
            self.insertRows(at: indexPathsForRows, with: animation)
        }
    }
    
    public func insertSubrows(_ subrows: [Int], in row: Int, with animation: UITableViewRowAnimation) {
        
        let indexPaths = subrows.map { (subrow: Int) -> IndexPath in
            
            IndexPath(row: row + subrow + 1, section: 0)
        }
        
        self.insertRows(at: indexPaths, with: animation)
    }
    
    public func deleteRows(at rows: [Int], with animation: UITableViewRowAnimation) {
        
        if let indexPathsForRows = self.dropDownDataSource?.tableView(self, indexPathsForRows: rows) {
            
            self.dropDownDataSource?.dropDownDeleteRows(rows, in: self)
            
            self.deleteRows(at: indexPathsForRows, with: animation)
        }
    }
    
    public func deleteSubrows(_ subrows: [Int], in row: Int, with animation: UITableViewRowAnimation) {
        
        let indexPaths = subrows.map { (subrow: Int) -> IndexPath in
            
            IndexPath(row: row + subrow + 1, section: 0)
        }
        
        self.deleteRows(at: indexPaths, with: animation)
    }
    
    public func reloadRows(at rows: [Int], with animation: UITableViewRowAnimation) {
        
        if let indexPathsForRows = self.dropDownDataSource?.tableView(self, indexPathsForRows: rows) {
            
            self.reloadRows(at: indexPathsForRows, with: animation)
        }
    }
    
    public func reloadSubrows(_ subrows: [Int], in row: Int, with animation: UITableViewRowAnimation) {
        
        if let indexPathsForSubrows = self.dropDownDataSource?.tableView(self, indexPathsForSubrows: subrows, inRow: row) {
                
            self.reloadRows(at: indexPathsForSubrows, with: animation)
        }
    }
    
    public func moveRow(at row: Int, to newRow: Int) {
        
        if let indexPathForRow = self.dropDownDataSource?.tableView(self, indexPathsForRows: [row]).first, let indexPathForNewRow = self.dropDownDataSource?.tableView(self, indexPathsForRows: [newRow]).first {
            
            self.moveRow(at: indexPathForRow, to: indexPathForNewRow)
        }
    }
    
    public func moveSubrow(_ subrow: Int, to newSubrow: Int, in row: Int) {
        
        let indexPathsForSubrows = self.dropDownDataSource?.tableView(self, indexPathsForSubrows: [subrow, newSubrow], inRow: row)
        
        if let indexPathForSubrow = indexPathsForSubrows?.first, let indexPathForNewSubrow = indexPathsForSubrows?.last {
            
            self.moveRow(at: indexPathForSubrow, to: indexPathForNewSubrow)
        }
    }
    
    public var rowForSelectedRow: Int? {
        
        if let indexPathForSelectedRow = self.indexPathForSelectedRow {
            
            return self.dropDownDataSource?.functionForIndexPath(indexPathForSelectedRow,
                                            functionForRow: { (row) -> Int in
                                                
                                                return row
                },
                                            functionForSubrow: { (subrow, row) -> Int? in
                                                
                                                return nil
            })
        }
        
        return nil
    }
    
    // IndexPath(forSubrow: Int, inMainRow: Int)
    public var indexPathForSelectedSubrow: IndexPath? {
        
        if let indexPathForSelectedRow = self.indexPathForSelectedRow {
            
            return self.dropDownDataSource?.functionForIndexPath(indexPathForSelectedRow,
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
            
        return self.indexPathsForSelectedRows?.flatMap({ (indexPath: IndexPath) -> Int? in
            
            self.dropDownDataSource?.functionForIndexPath(indexPath,
                                                          functionForRow: { (row) -> Int in
                                                            
                                                            return row
                                                            
                },
                                                          functionForSubrow: { (subrow, row) -> Int? in
                                                            
                                                            return nil
            })
        })
    }
    
    // IndexPath(forSubrow: Int, inMainRow: Int)
    public var indexPathsForSelectedSubrows: [IndexPath]? {
            
        return self.indexPathsForSelectedRows?.flatMap({ (indexPath: IndexPath) -> IndexPath? in
            
            self.dropDownDataSource?.functionForIndexPath(indexPath,
                                                          functionForRow: { (row) -> IndexPath? in
                                                            
                                                            return nil
                                                            
                },
                                                          functionForSubrow: { (subrow, row) -> IndexPath in
                                                            
                                                            return IndexPath(forSubrow: subrow, inMainRow: row)
            })
        })
    }
    
    public func selectRowAt(_ row: Int?, animated: Bool, scrollPosition: UITableViewScrollPosition) {
        
        if let row = row, let indexPathForRow = self.dropDownDataSource?.tableView(self, indexPathsForRows: [row]).first {
            
            self.selectRow(at: indexPathForRow, animated: animated, scrollPosition: scrollPosition)
        
        } else {
            
            self.selectRow(at: nil, animated: animated, scrollPosition: scrollPosition)
        }
    }
    
    // IndexPath(forSubrow: Int, inMainRow: Int)
    public func selectSubrow(at indexPath: IndexPath?, animated: Bool, scrollPosition: UITableViewScrollPosition) {
        
        if let indexPath = indexPath, let indexPathForSubrow = self.dropDownDataSource?.tableView(self, indexPathsForSubrows: [indexPath.subrow], inRow: indexPath.mainrow).first {
                
                self.selectRow(at: indexPathForSubrow, animated: animated, scrollPosition: scrollPosition)
            
        } else {
            
            self.selectRow(at: nil, animated: animated, scrollPosition: scrollPosition)
        }
    }
    
    public func deselectRow(at row: Int, animated: Bool) {
        
        if let indexPathForRow = self.dropDownDataSource?.tableView(self, indexPathsForRows: [row]).first {
            
            self.deselectRow(at: indexPathForRow, animated: animated)
        }
    }
    
    // IndexPath(forSubrow: Int, inMainRow: Int)
    public func deselectSubrow(at indexPath: IndexPath, animated: Bool) {
        
        if let indexPathForSubrow = self.dropDownDataSource?.tableView(self, indexPathsForSubrows: [indexPath.subrow], inRow: indexPath.mainrow).first {
            
            self.deselectRow(at: indexPathForSubrow, animated: animated)
        }
    }
}
