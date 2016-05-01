//
//  NSIndexPath+DropDown.swift
//  DropDownTableView
//
//  Created by NSSimpleApps on 23.04.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

import Foundation


// mainrow0 /\
//    subrow0       -> NSIndexPath(forSubrow: 0, mainrow: 0)
//    subrow1       -> NSIndexPath(forSubrow: 1, mainrow: 0)
//    subrow2       -> NSIndexPath(forSubrow: 2, mainrow: 0)
//    subrow3       -> NSIndexPath(forSubrow: 3, mainrow: 0)
// mainrow1 \/


public extension NSIndexPath {
    
    public convenience init(forSubrow subrow: Int, inMainRow mainrow: Int) {
        
        self.init(indexes: [subrow, mainrow], length: 2)
    }
    
    public var subrow: Int {
        
        var result = 0
        
        self.getIndexes(&result, range: NSRange(location: 0, length: 1))
        
        return result
    }
    
    public var mainrow: Int {
        
        var result = 0
        
        self.getIndexes(&result, range: NSRange(location: 1, length: 1))
        
        return result
    }
}