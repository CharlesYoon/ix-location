//
//  AddActivityViewController.swift
//  ixLocation
//
//  Created by Miki von Ketelhodt on 2017/06/04.
//  Copyright © 2017 RBG Applications. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController {

    var newActivity: Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveActivity(_ sender: Any) {
        // TODO: Save!
        print(newActivity)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
