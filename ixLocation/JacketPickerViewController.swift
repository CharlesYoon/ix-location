//
//  JacketPickerViewController.swift
//  ixLocation
//
//  Created by Miki von Ketelhodt on 2017/06/04.
//  Copyright © 2017 RBG Applications. All rights reserved.
//

import UIKit

class JacketWearerViewController: UIViewController, JacketPickerDelegate {
    
    var jacketPicker: JacketPicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        jacketPicker = JacketPicker(withDelegate: self)
        jacketPicker.pickJacketFromSomewhere()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func preferredJacketColor(jacketPicker: JacketPicker) -> UIColor? {
        return UIColor(red: 1, green: 165/255, blue: 0, alpha: 1)
    }
    
    func didPickJacket(jacketPicker: JacketPicker, jacket: Jacket) {
        putJacketOn(jacket: jacket)
    }
    
    func putJacketOn(jacket: Jacket) {
        // Lets put the jacket on
    }

}
