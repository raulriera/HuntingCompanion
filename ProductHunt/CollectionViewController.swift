//
//  CollectionViewController.swift
//  ProductHunt
//
//  Created by Raúl Riera on 03/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit
import HuntingKit

class CollectionViewController: PostsViewController {
    
    @IBOutlet private weak var screenshotImageView: UIImageView!
    
    var collection: Collection?
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        autoloads = false
        
        super.viewDidLoad()
        
        if let collection = collection {
            title = collection.name
            if let imageURL = collection.imageURL {
                screenshotImageView.hnk_setImageFromURL(imageURL)
            }
            
            if let websiteURL = collection.discussionURL {
                updateUserActivityForWebsite(websiteURL)
            }
            
            let request = ProductHunt.Endpoint.Collection(collection: collection)
            
            ProductHunt.sendRequest(request) { [unowned self] response in
                switch response {
                case .Success(let box):
                    let collection = box.unbox
                    self.posts = [collection.posts]
                    
                case .Failure(let box):
                    self.displayError(box.unbox)
                }
                self.tableView.tableFooterView = nil
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        userActivity?.invalidate()
    }
    
    // MARK: UITableView Datasource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return posts.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.first?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerHeight = super.tableView(tableView, heightForHeaderInSection: section)
        let headerWidth = tableView.frame.width
        
        let headerView = CenteredTableViewHeader(frame: CGRect(origin: CGPointZero, size: CGSize(width: headerWidth, height: headerHeight)))
        if let count = posts.first?.count {
            headerView.label?.text = "\(count) products"
        } else {
            headerView.label?.text = "Products"
        }
        return headerView
    }
}
