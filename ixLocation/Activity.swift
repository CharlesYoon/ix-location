//
//  Activity.swift
//  ixLocation
//
//  Created by Miki von Ketelhodt on 2017/06/04.
//  Copyright © 2017 RBG Applications. All rights reserved.
//

import Foundation
import UIKit

class Activity {
    
    var name: String
    var description: String
    var image: UIImage?
    var rating: Int
    var location: GeoPoint
    
    init?() {
        self.name = ""
        self.description = ""
        self.image = nil
        self.rating = 0
        self.location = GeoPoint(latitude: 0.0, longitude: 0.0)
    }
    
}
