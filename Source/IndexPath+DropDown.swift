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


public extension IndexPath {
    
    public init(forSubrow subrow: Int, inMainRow mainrow: Int) {
        
        self.init(indexes: [subrow, mainrow])
    }
    
    public var subrow: Int {
        
        return self[0]
    }
    
    public var mainrow: Int {
        
        return self[1]
    }
}
