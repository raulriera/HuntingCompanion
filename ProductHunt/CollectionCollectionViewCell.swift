//
//  CollectionCollectionViewCell.swift
//  ProductHunt
//
//  Created by Raúl Riera on 03/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit
import HuntingKit
import Haneke

class CollectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var screenshotImageView: UIImageView!
    @IBOutlet private weak var avatarImageView: CircularImageView!
    
    var collection:Collection? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        if let collection = collection {
            nameLabel.text = collection.name
            titleLabel.text = collection.title
            
            if let imageURL = collection.imageURL {
                screenshotImageView.hnk_setImageFromURL(imageURL)
            }
            if let avatarURL = collection.user.imagesURL[.Retina44] {
                avatarImageView.hnk_setImageFromURL(avatarURL)
            }
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        screenshotImageView.hnk_cancelSetImage()
        screenshotImageView.image = nil
        
        avatarImageView.hnk_cancelSetImage()
        avatarImageView.image = nil
    }
}
