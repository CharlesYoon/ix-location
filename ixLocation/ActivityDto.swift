//
//  Activity.swift
//  ixLocation
//
//  Created by Miki von Ketelhodt on 2017/06/04.
//  Copyright © 2017 RBG Applications. All rights reserved.
//

import Foundation
import UIKit
import Gloss

class ActivityDto: Decodable, Glossy {
    
    var name: String?
    var description: String?
    var image: UIImage?
    var location: GeoPoint?
    var imageUrl: String?
    var featureA: String?
    var featureB: String?
    
    init?() {
        self.name = ""
        self.description = ""
        self.image = nil
        self.location = GeoPoint(latitude: 0.0, longitude: 0.0)
        self.imageUrl = ""
    }
    
    required init?(json: JSON) {
        self.name = "name" <~~ json
        self.description = "description" <~~ json
        self.location = "location" <~~ json
        self.imageUrl = "imageUrl" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "name" ~~> self.name,
            "description" ~~> self.description,
            "location" ~~> self.location,
            "imageUrl" ~~> self.imageUrl
        ])
    }
    
}
