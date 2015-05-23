//
//  CommentTableViewCell.swift
//  ProductHunt
//
//  Created by Raúl Riera on 16/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit
import HuntingKit
import Haneke
import UpvoteControl

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var commenterNameLabel: UILabel!
    @IBOutlet private weak var commenterCompanyLabel: UILabel!
    @IBOutlet private weak var commenterImageView: CircularImageView!
    
    var comment: Comment? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        if let comment = comment {
            commenterNameLabel.text = comment.user.name
            commenterCompanyLabel.text = comment.user.headline
            bodyLabel.text = comment.body
            // this is insanely slow, but displays images, etc
            //bodyLabel.attributedText = encodedStringToAttributedString(comment.body)
            
            if let avatarURL = comment.user.imagesURL[.Retina44] {
                commenterImageView.hnk_setImageFromURL(avatarURL)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        commenterImageView.hnk_cancelSetImage()
        commenterImageView.image = nil
    }
    
    private func stripHTML(string: String) -> String {
        return string.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
    }
    
    private func encodedStringToAttributedString(string: String) -> NSAttributedString {
        let encodedData = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
        let attributedOptions : [String: AnyObject] = [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType]
        return NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil, error: nil)!
    }
    
}
