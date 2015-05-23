//
//  CenteredTableViewHeader.swift
//  ProductHunt
//
//  Created by Raúl Riera on 03/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

class CenteredTableViewHeader : UIView {
    final var label: UILabel?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    private func configureView() {
        backgroundColor = UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 0.9)
        contentMode = .Redraw
        
        label = UILabel(frame: frame)
        if let label = label {
            label.font = UIFont(name: "Optima", size: 12)
            label.textAlignment = .Center
            label.setTranslatesAutoresizingMaskIntoConstraints(false)
            
            addSubview(label)
            
            let views = ["label": label]
            
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[label]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[label]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        }
    }
}