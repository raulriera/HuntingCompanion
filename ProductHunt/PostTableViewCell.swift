//
//  PostTableViewCell.swift
//  ProductHunt
//
//  Created by Raúl Riera on 25/04/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit
import HuntingKit
import Haneke
import UpvoteControl

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var upvoteControl: UpvoteControl!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var taglineLabel: UILabel!
    @IBOutlet private weak var hunterImageView: CircularImageView!
        
    var post:Post? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        if let post = post {
            nameLabel.text = post.name
            taglineLabel.text = post.tagline
            
            if let avatarURL = post.user.imagesURL[.Retina44] {
                hunterImageView.hnk_setImageFromURL(avatarURL)
            }
            
            if let votes = post.stats?.votes {
                upvoteControl.count = votes
            }            
        }
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        preserveUpvoteBackgroundColor()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        preserveUpvoteBackgroundColor()
    }
    
    private func preserveUpvoteBackgroundColor() {
        upvoteControl.backgroundColor = UIColor(red:0.949, green:0.95, blue:0.965, alpha:1)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        hunterImageView.hnk_cancelSetImage()
        hunterImageView.image = nil
    }
    
}
