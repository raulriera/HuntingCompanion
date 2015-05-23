//
//  UIStoryboardSegueExt.swift
//  Swish
//
//  Created by Raúl Riera on 03/04/2015.
//  Copyright (c) 2015 com.raulriera.swishapp. All rights reserved.
//

import UIKit

extension UIStoryboardSegue {
}

public func ==(lhs: UIStoryboardSegue, rhs: SegueIdentifier) -> Bool {
    return lhs.identifier == rhs.rawValue
}