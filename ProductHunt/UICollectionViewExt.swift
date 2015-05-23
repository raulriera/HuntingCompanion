//
//  UICollectionViewExt.swift
//  ProductHunt
//
//  Created by Raúl Riera on 04/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    /**
    Helper method when using `sbconstants gem`.
    
    :param: identifier A string identifying the cell object to be reused.
    :param: indexPath The index path specifying the location of the cell.
    */
    public func dequeueReusableCell(identifier: CollectionViewCellreuseIdentifier, forIndexPath indexPath: NSIndexPath) -> AnyObject {
        return dequeueReusableCellWithReuseIdentifier(identifier.rawValue, forIndexPath: indexPath)
    }
}
