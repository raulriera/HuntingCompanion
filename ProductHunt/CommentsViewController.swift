//
//  CommentsTableViewController.swift
//  ProductHunt
//
//  Created by Raúl Riera on 15/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit
import HuntingKit

class CommentsViewController: UITableViewController, Resizable {
    
    var comments = [Comment]() {
        didSet {
            tableView.reloadData()
            //didChangeContentSize?(size: contentSize())
        }
    }
    
    var counter = 0
    
    // MARK: - Resizable
    
    var didChangeContentSize: ContentSizeClosure?
    
    func contentSize() -> CGSize {
        return tableView.contentSize
    }
    
    // MARK: View Controller Lifecycle
    
    override func viewDidLayoutSubviews() {
        didChangeContentSize?(size: contentSize())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Enable row cell auto resizing
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(.CommentTableViewCell, forIndexPath: indexPath) as! CommentTableViewCell
        
        cell.comment = comments[indexPath.row]
        
        return cell
    }
    
    
    
}

