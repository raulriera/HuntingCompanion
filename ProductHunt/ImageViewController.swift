//
//  ImageViewController.swift
//  ProductHunt
//
//  Created by Raúl Riera on 23/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit
import UpvoteControl
import HuntingKit

class ImageViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView?
    
    var imageURL: NSURL?
    
    private func updateViews() {
        if let imageURL = imageURL, let imageView = imageView {
            imageView.hnk_setImageFromURL(imageURL)
        }
    }
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
}
