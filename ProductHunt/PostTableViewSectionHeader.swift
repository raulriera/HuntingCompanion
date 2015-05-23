//
//  PostTableViewSectionHeader.swift
//  ProductHunt
//
//  Created by Raúl Riera on 26/04/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

class PostTableViewSectionHeader: CenteredTableViewHeader {
    
    var section:Int = 0 {
        didSet {
            let dateFormatter = NSDateFormatter()
            let dateString: String
            switch section {
            case 0:
                dateString = "Today"
            case 1:
                dateString = "Yesterday"
            default:
                dateFormatter.dateFormat = "EEEE, MMMM dd"
                let components:NSDateComponents = NSDateComponents()
                components.day = -section
                
                if let date = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: NSDate(), options: nil) {
                    dateString = dateFormatter.stringFromDate(date)
                } else {
                    dateString = dateFormatter.stringFromDate(NSDate())
                }
            }
            
            label?.text = dateString
        }
    }
}
