//
//  CircularImageView.swift
//  ProductHunt
//
//  Created by Raúl Riera on 26/04/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

@IBDesignable
class CircularImageView: UIImageView {
    
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.clearColor()
    
    override func layoutSublayersOfLayer(layer: CALayer!) {
        super.layoutSublayersOfLayer(layer)
        layer.cornerRadius = bounds.width/2
        clipsToBounds = true
        
        if borderWidth > 0 {
            layer.borderWidth = borderWidth
            layer.borderColor = borderColor.CGColor
        }        
    }
    
    override func prepareForInterfaceBuilder() {        
        backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.95)
    }
}