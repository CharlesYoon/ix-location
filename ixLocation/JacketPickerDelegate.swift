//
//  JacketPickerDelegate.swift
//  ixLocation
//
//  Created by Miki von Ketelhodt on 2017/06/04.
//  Copyright © 2017 RBG Applications. All rights reserved.
//

import Foundation
import UIKit

protocol JacketPickerDelegate {
    func preferredJacketColor(jacketPicker: JacketPicker) -> UIColor?
    func didPickJacket(jacketPicker: JacketPicker, jacket: Jacket)
}
