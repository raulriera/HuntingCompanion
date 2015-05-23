//
//  PostsViewController.swift
//  ProductHunt
//
//  Created by Raúl Riera on 19/04/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit
import HuntingKit
import LoadingButton

class PostsViewController: UITableViewController {
    
    @IBOutlet weak var previousDayButton: LoadingButton?
    
    private let clientId = "91c3e0dd5bc6fbee69154855149f9b8af750e294d8a2d5749a3a7393201f0ef5"
    private let clientSecret = "c1c26f855a73217785129ce83ad389b8a6823f98db17c68e5c159122c8ee729e"
    
    /// Immediately send a request to get the latests posts from the API
    final var autoloads = true
    
    var posts = [[Post]]() {
        didSet {
            tableView.reloadData()
            if let previousDayButton = previousDayButton {
                previousDayButton.endLoading()
            }
        }
    }

    // MARK: View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let previousDayButton = previousDayButton {
            previousDayButton.beginLoading()
        }
        
        // Enable row cell auto resizing
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if autoloads {
            let authenticationRequest = ProductHunt.Endpoint.ClientToken(id: clientId, secret: clientSecret)
            
            ProductHunt.sendRequest(authenticationRequest) { response in
                switch response {
                case .Success(let box):
                    let accessToken = box.unbox
                    let request = ProductHunt.Endpoint.Posts(from: .Today)
                    
                    ProductHunt.sendRequest(request) { [unowned self] response in
                        switch response {
                        case .Success(let box):
                            let posts = box.unbox
                            self.posts = [posts]
                            
                        case .Failure(let box):
                            self.displayError(box.unbox)
                        }
                    }
                    
                case .Failure(let box):
                    self.displayError(box.unbox)
                }
            }
        }
        
    }
        
    override func displayError(error: NSError) {
        super.displayError(error)
        
        if let previousDayButton = previousDayButton {
            previousDayButton.endLoading()
        }
    }
    
    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == .ShowPostSegue {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let post = posts[indexPath.section][indexPath.row] as Post
                if let destinationViewController = segue.destinationViewController.contentViewController as? PostViewController {
                    destinationViewController.post = post
                    destinationViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                    destinationViewController.navigationItem.leftItemsSupplementBackButton = true
                }
            }
        }
    }
    
    // MARK: - IB Actions
    
    @IBAction func didTapPreviousDay(sender: LoadingButton) {
        let request = ProductHunt.Endpoint.Posts(from: .DaysAgo(tableView.numberOfSections()))
        
        ProductHunt.sendRequest(request) { [unowned self] response in
            switch response {
            case .Success(let box):
                let posts = box.unbox
                self.posts.append(posts)
                
            case .Failure(let box):
                self.displayError(box.unbox)
            }
        }
    }
    
    @IBAction func refreshControlDidChangeValue(sender: UIRefreshControl) {
        
        let request = ProductHunt.Endpoint.Posts(from: .Today)
        
        ProductHunt.sendRequest(request) { [unowned self] response in
            switch response {
            case .Success(let box):
                let posts = box.unbox
                self.posts = [posts]
                sender.endRefreshing()
                
            case .Failure(let box):
                self.displayError(box.unbox)
                sender.endRefreshing()
            }
        }
    }
    
    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return posts.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(.PostTableViewCell, forIndexPath: indexPath) as! PostTableViewCell

        cell.post = posts[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerHeight = super.tableView(tableView, heightForHeaderInSection: section)
        let headerWidth = tableView.frame.width
        
        let headerView = PostTableViewSectionHeader(frame: CGRect(origin: CGPointZero, size: CGSize(width: headerWidth, height: headerHeight)))
        headerView.section = section
        return headerView
    }

}
