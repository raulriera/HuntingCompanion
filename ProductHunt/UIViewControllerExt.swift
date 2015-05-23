//
//  UIViewControllerExt.swift
//  ProductHunt
//
//  Created by Raúl Riera on 03/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func displayError(error: NSError) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(action)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // If a navigation controller it will return the first visible view controller, otherwise
    // it will return itself
    var contentViewController: UIViewController {
        if let navigationController = self as? UINavigationController {
            return navigationController.visibleViewController
        } else {
            return self
        }
    }
    
    /**
    Helper method when using `sbconstants gem`.
    Created by the guys at https://github.com/artsy/eidolon/
    
    :param: identifier of the segue to perform
    */
    public func performSegue(identifier:SegueIdentifier) {
        performSegueWithIdentifier(identifier.rawValue, sender: self)
    }
    
    /**
    Helper method to quickly fire a handoff to a given website
    
    :param: url to handoff to
    */
    public func updateUserActivityForWebsite(url: NSURL) {
        let activity = NSUserActivity(activityType: "com.raulriera.producthunt.handoff.web")
        activity.webpageURL = url
        activity.becomeCurrent()
        userActivity = activity
    }
}