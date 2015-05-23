//
//  CollectionsCollectionViewController.swift
//  ProductHunt
//
//  Created by Raúl Riera on 03/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit
import HuntingKit

class CollectionsCollectionViewController: UICollectionViewController {
    
    private var collections = [Collection]() {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        let request = ProductHunt.Endpoint.Collections(featured: true)
        
        ProductHunt.sendRequest(request) { [unowned self] response in
            switch response {
            case .Success(let box):
                self.collections = box.unbox
                
            case .Failure(let box):
                self.displayError(box.unbox)
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(.CollectionCollectionViewCell, forIndexPath: indexPath) as! CollectionCollectionViewCell
        
        cell.collection = collections[indexPath.row]
        
        return cell
    }
    
    // MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == .ShowCollectionSegue {
            if let destinationViewController = segue.destinationViewController.contentViewController as? CollectionViewController {
                if let indexPaths = collectionView?.indexPathsForSelectedItems() as? [NSIndexPath] {
                    destinationViewController.collection = collections[indexPaths.first!.row]
                }
            }
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        performSegue(.ShowCollectionSegue)
    }

    // MARK: UIContentContainer
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}

extension CollectionsCollectionViewController : UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
            let size:CGSize
            let minimumInteritemSpacing:CGFloat = (collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing
            
            let screen = UIScreen.mainScreen().bounds.size
            let cellWidth: CGFloat
            let cellHeight: CGFloat
            let availableVerticalSpace = screen.height - collectionView.contentInset.top - collectionView.contentInset.bottom
            
            if traitCollection.horizontalSizeClass == .Regular {
                cellWidth = (screen.width - minimumInteritemSpacing) / 2
            } else {
                cellWidth = screen.width
            }
            
            cellHeight = min(cellWidth * 0.75, availableVerticalSpace)
            size = CGSize(width: cellWidth, height: cellHeight)
            
            return size
    }

}