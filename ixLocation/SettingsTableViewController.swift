//
//  SettingsTableViewController.swift
//  ixLocation
//
//  Created by Miki von Ketelhodt on 2017/06/05.
//  Copyright © 2017 RBG Applications. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0 {
            self.tabBarController?.selectedIndex = 2
        }
        
        if indexPath.section == 1 && indexPath.row == 1 {
            self.tabBarController?.selectedIndex = 1
        }
    }

}
