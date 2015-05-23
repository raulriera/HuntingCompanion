//
//  StateViewContoller.swift
//  ProductHunt
//
//  Created by Raúl Riera on 11/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

class StateViewContoller: UIViewController {
    
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var imageView: UIImageView!
        
    override func loadView() {
        let applicationFrame = UIScreen.mainScreen().applicationFrame
        let contentView = UIView(frame: applicationFrame)
        contentView.backgroundColor = UIColor.whiteColor()
        view = contentView
        
        titleLabel = UILabel(frame: view.bounds)
        titleLabel.textAlignment = .Center
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)

        descriptionLabel = UILabel(frame: view.bounds)
        descriptionLabel.textAlignment = .Center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .ByWordWrapping
        descriptionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let views = ["titleLabel": titleLabel, "descriptionLabel": descriptionLabel]
        
        // Center the title in the view and pin it to the edges
        view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: -20))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[titleLabel]-20-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))

        // Pin the description to the title
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[descriptionLabel]-20-|", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[titleLabel]-4-[descriptionLabel]", options: NSLayoutFormatOptions(0), metrics: nil, views: views))
        
    }
}
