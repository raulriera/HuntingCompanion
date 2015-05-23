//
//  PostHeaderViewController.swift
//  ProductHunt
//
//  Created by Raúl Riera on 13/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit
import UpvoteControl
import HuntingKit

class PostHeaderViewController: UIViewController {
    
    @IBOutlet private weak var upvoteControl: UpvoteControl?
    @IBOutlet private weak var nameLabel: UILabel?
    @IBOutlet private weak var taglineLabel: UILabel?
    @IBOutlet private weak var createdAtLabel: UILabel?
    @IBOutlet private weak var makerImageView: CircularImageView?
    @IBOutlet private weak var hunterImageView: CircularImageView?
    @IBOutlet private weak var getItButton: RoundedButton?
    
    var post:Post?
    
    private func updateViews() {
        if let post = post, let nameLabel = nameLabel, let taglineLabel = taglineLabel, let makerImageView = makerImageView, let hunterImageView = hunterImageView, let createdAtLabel = createdAtLabel, let upvoteControl = upvoteControl {
            
            nameLabel.text = post.name
            taglineLabel.text = post.tagline
            
            if let createdAt = post.stats?.createdAt {
                let formatter = NSDateFormatter()
                formatter.dateStyle = .MediumStyle
                createdAtLabel.text = formatter.stringFromDate(createdAt)
            } else {
                createdAtLabel.text = "Hmmm don't remember when"
            }
            
            if let maker = post.makers.first, let avatarURL = maker.imagesURL[.Retina44] {
                makerImageView.hnk_setImageFromURL(avatarURL)
            } else {
                let widthConstraint = makerImageView.layoutConstraint(attribute: .Width)
                widthConstraint?.constant = 0
            }
            
            if let avatarURL = post.user.imagesURL[.Retina32] {
                hunterImageView.hnk_setImageFromURL(avatarURL)
            }
                        
            if let votes = post.stats?.votes {
                upvoteControl.count = votes
            }
        }
    }

    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    // MARK: IBActions
    
    @IBAction func didTapGetIt(sender: UIButton) {
        if let post = post, let redirectURL = post.redirectURL {
            UIApplication.sharedApplication().openURL(redirectURL)
        }
    }
}
