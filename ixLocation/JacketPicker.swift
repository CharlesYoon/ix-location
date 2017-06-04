//
//  JacketPicker.swift
//  ixLocation
//
//  Created by Miki von Ketelhodt on 2017/06/04.
//  Copyright © 2017 RBG Applications. All rights reserved.
//

import Foundation
import UIKit

class JacketPicker {
    var delegate: JacketPickerDelegate?
    var jacket: Jacket
    
    init(withDelegate delegate: JacketPickerDelegate?) {
        self.delegate = delegate
    }
    
    func setup() {
        self.jacket = Jacket()
        
        if let preferredJacketColor = self.delegate?.preferredJacketColor(jacketPicker: self) {
            self.jacket.color = preferredJacketColor
        } else {
            self.jacket.color = UIColor.black // default
        }
    }
    
    func pickJacketFromSomewhere() {
        delegate?.didPickJacket(jacketPicker: self, jacket: self.jacket)
    }
}
