//
//  PostViewController.swift
//  ProductHunt
//
//  Created by Raúl Riera on 19/04/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit
import HuntingKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var headerContainerView: UIView!
    @IBOutlet weak var relatedProductsContainerView: UIView!
    @IBOutlet weak var upvotesContainerView: UIView!
    @IBOutlet weak var commentsContainerView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    
    private var postHeaderViewController: PostHeaderViewController?
    private var postVotesCollectionViewController: PostVotesCollectionViewController?
    private var postCommentsTableViewController: CommentsViewController?
    private var imageViewController: ImageViewController?
    
    private enum Section {
        case Header
        case RelatedProducts
        case Upvotes
        case Comments
    }
    
    var post: Post? {
        didSet {
            updateView()
        }
    }

    private func updateView() {
        // Update the user interface for the detail item.
        if let post: Post = self.post {
            title = post.name
            if let websiteURL = post.discussionURL {
                updateUserActivityForWebsite(websiteURL)
            }
        }
    }
    
    private func viewLayoutContainerViews() {
        
        let commentsContainerViewHeightConstraint = commentsContainerView.layoutConstraint(attribute: .Height)
        commentsContainerViewHeightConstraint?.constant = postCommentsTableViewController?.tableView.contentSize.height ?? 0

        dispatch_async(dispatch_get_main_queue(), {
            self.view.layoutIfNeeded()
        })        
    }
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
        if let post = post {
            let request = ProductHunt.Endpoint.Post(post: post)
            
            ProductHunt.sendRequest(request) { [weak self] response in
                switch response {
                case .Success(let box):
                    self?.postVotesCollectionViewController?.votes = box.unbox.votes
                    if let comments = box.unbox.comments {
                        self?.postCommentsTableViewController?.comments = comments
                    }
                    self?.post = box.unbox
                    
                case .Failure(let box):
                    self?.displayError(box.unbox)
                }
            }
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        userActivity?.invalidate()
    }

    // MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue == .PostHeaderEmbedSegue {
            if let destinationViewController = segue.destinationViewController as? PostHeaderViewController {
                destinationViewController.post = post
                postHeaderViewController = destinationViewController
            }
        } else if segue == .PostVotesEmbedSegue {
            if let destinationViewController = segue.destinationViewController as? PostVotesCollectionViewController {
                postVotesCollectionViewController = destinationViewController
            }
        } else if segue == .PostCommentsEmbedSegue {
            if let destinationViewController = segue.destinationViewController as? CommentsViewController {
                postCommentsTableViewController = destinationViewController
                postCommentsTableViewController?.didChangeContentSize = { [unowned self] size in
                    self.viewLayoutContainerViews()
                }
            }
        } else if segue == .ImageEmbedSegue {
            if let destinationViewController = segue.destinationViewController as? ImageViewController {
                imageViewController = destinationViewController
                imageViewController?.imageURL = post?.imagesURL[.Size850]
            }
        }
    }

}

