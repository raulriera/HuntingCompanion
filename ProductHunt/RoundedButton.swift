//
//  RoundedButton.swift
//  ProductHunt
//
//  Created by Raúl Riera on 13/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.clearColor()
    
    override func layoutSublayersOfLayer(layer: CALayer!) {
        super.layoutSublayersOfLayer(layer)
        layer.cornerRadius = bounds.height/2
        clipsToBounds = true
        
        if borderWidth > 0 {
            layer.borderWidth = borderWidth
            layer.borderColor = borderColor.CGColor
        }
    }

}
