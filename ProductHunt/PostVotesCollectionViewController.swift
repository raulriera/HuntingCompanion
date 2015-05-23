//
//  PostVotesCollectionViewController.swift
//  ProductHunt
//
//  Created by Raúl Riera on 14/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit
import HuntingKit

class PostVotesCollectionViewController: UICollectionViewController {
    
    var votes:[Vote] = [Vote]() {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    // MARK: View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView?.scrollIndicatorInsets = insets
        collectionView?.contentInset = insets
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return votes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(.VoteCollectionViewCell, forIndexPath: indexPath) as! VoteCollectionViewCell
    
        // Configure the cell
        cell.vote = votes[indexPath.row]
    
        return cell
    }

}
