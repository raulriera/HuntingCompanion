//
//  VoteCollectionViewCell.swift
//  ProductHunt
//
//  Created by Raúl Riera on 14/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit
import HuntingKit
import Haneke

class VoteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var avatarImageView: CircularImageView!
    
    var vote:Vote? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        if let user = vote?.user, let avatarURL = user.imagesURL[.Retina44] {
            avatarImageView.hnk_setImageFromURL(avatarURL)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        avatarImageView.hnk_cancelSetImage()
        avatarImageView.image = nil
    }
}

