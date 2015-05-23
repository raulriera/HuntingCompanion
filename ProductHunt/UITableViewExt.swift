//
//  UITableViewExt.swift
//  Swish
//
//  Created by Raúl Riera on 03/04/2015.
//  Copyright (c) 2015 com.raulriera.swishapp. All rights reserved.
//

import UIKit

extension UITableView {
    
    /**
    Helper method when using `sbconstants gem`.
    
    :param: identifier A string identifying the cell object to be reused.
    :param: indexPath The index path specifying the location of the cell.
    */
    public func dequeueReusableCell(identifier: TableViewCellreuseIdentifier, forIndexPath indexPath: NSIndexPath) -> AnyObject {
        return dequeueReusableCellWithIdentifier(identifier.rawValue, forIndexPath: indexPath)
    }
}
