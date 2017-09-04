//
//  Video.swift
//  Youtube
//
//  Created by Kleyton Santos on 9/4/17.
//  Copyright © 2017 Kleyton Santos. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbnail: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
    
}

class Channel: NSObject {
    var name: String?
    var profimeImageName: String?
}
    
