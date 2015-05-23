//
//  Resizable.swift
//  ProductHunt
//
//  Created by Raúl Riera on 16/05/2015.
//  Copyright (c) 2015 Raul Riera. All rights reserved.
//

import UIKit

typealias ContentSizeClosure = (size: CGSize) -> ()

protocol Resizable {
    func contentSize() -> CGSize
    var didChangeContentSize: ContentSizeClosure? { get }
}