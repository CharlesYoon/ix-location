//
//  AddActivityDelegate.swift
//  ixLocation
//
//  Created by Miki von Ketelhodt on 2017/06/04.
//  Copyright © 2017 RBG Applications. All rights reserved.
//

import Foundation

protocol AddActivityDelegate {
    func didSaveActivity(activity: ActivityDto)
    func didCancelActivity()
}
