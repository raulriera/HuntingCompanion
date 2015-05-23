//
//  SplitViewController.swift
//  ProductHunt
//
//  Created by Raúl Riera on 26/04/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationController = viewControllers[viewControllers.count-1] as? UINavigationController
        navigationController?.topViewController.navigationItem.leftBarButtonItem = displayModeButtonItem()
        delegate = self
    }
    
    // MARK: UISplitViewControllerDelegate
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController!, ontoPrimaryViewController primaryViewController:UIViewController!) -> Bool {
        if let secondaryAsNavController = secondaryViewController as? UINavigationController {
            if let topAsDetailController = secondaryAsNavController.topViewController as? PostViewController {
                if topAsDetailController.post == nil {
                    // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
                    return true
                }
            }
        }
        return false
    }


}
