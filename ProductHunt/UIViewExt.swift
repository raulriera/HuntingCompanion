//
//  UIViewExt.swift
//  ProductHunt
//
//  Created by Raúl Riera on 13/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

extension UIView {
    /**
    Returns the matching attribute constraint held by the view.
    
    :param: attribute of the constraint
    
    :returns: the matching constraint
    */
    public func layoutConstraint(#attribute: NSLayoutAttribute) -> NSLayoutConstraint? {
        return layoutConstraints(attributes: [attribute]).first
    }
    
    /**
    Returns the matching attribute constraints held by the view.
    
    :param: attribute of the constraints
    
    :returns: the matching constraints
    */
    public func layoutConstraints(#attribute: NSLayoutAttribute) -> [NSLayoutConstraint] {
        return layoutConstraints(attributes: [attribute])
    }
    
    /**
    Returns the matching attributes constraints held by the view.
    
    :param: array of attributes of the constraints
    
    :returns: the matching constraints
    */
    public func layoutConstraints(#attributes: [NSLayoutAttribute]) -> [NSLayoutConstraint] {
        var layoutConstraints = [NSLayoutConstraint]()
        
        if let superviewConstrains = superview?.constraints() as? [NSLayoutConstraint] {
            layoutConstraints += superviewConstrains
        }
        
        if let viewConstrains = constraints() as? [NSLayoutConstraint] {
            layoutConstraints += viewConstrains
        }
        
        let filteredConstraints = layoutConstraints.filter { (layoutConstraint) in
            return contains(attributes, layoutConstraint.firstAttribute)
        }.filter { (layoutConstraint) in
            if let secondItem: AnyObject = layoutConstraint.secondItem {
                return layoutConstraint.firstItem.isEqual(self) || secondItem.isEqual(self)
            } else {
                return layoutConstraint.firstItem.isEqual(self)
            }
        }
        
        return filteredConstraints
    }

}

