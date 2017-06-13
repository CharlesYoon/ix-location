//
//  Activity.swift
//  ixLocation
//
//  Created by Miki von Ketelhodt on 2017/06/11.
//  Copyright © 2017 RBG Applications. All rights reserved.
//

import Realm

class Activity: RLMObject {
    dynamic var name = ""
    dynamic var descr = ""
    dynamic var lat = 0.0
    dynamic var lng = 0.0
}
