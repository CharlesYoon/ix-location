//
//  SettingsTableViewController.swift
//  ixLocation
//
//  Created by Miki von Ketelhodt on 2017/06/05.
//  Copyright © 2017 RBG Applications. All rights reserved.
//

import UIKit
import MapKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }   
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
        let mapType = UserDefaults.standard.string(forKey: "mapType")
        
        if indexPath.section == 2 && mapType == nil {
            cell.accessoryType = .checkmark
        }
        
        if indexPath.section == 2 && indexPath.row == 0 && mapType == "hybrid" {
            cell.accessoryType = .checkmark
        }
        
        if indexPath.section == 2 && indexPath.row == 1 && mapType == "hybridFlyover" {
            cell.accessoryType = .checkmark
        }
         
        if indexPath.section == 2 && indexPath.row == 2 && mapType == "satelite" {
            cell.accessoryType = .checkmark
        }
         
        if indexPath.section == 2 && indexPath.row == 3 && mapType == "sateliteFlyover" {
            cell.accessoryType = .checkmark
        }
         
        if indexPath.section == 2 && indexPath.row == 4 && mapType == "standard" {
            cell.accessoryType = .checkmark
        }
    }
    
    /*
     Different map types
     map.mapType = .hybrid              == section 2, row 0
     map.mapType = .hybridFlyover       == section 2, row 1
     map.mapType = .satellite           == section 2, row 2
     map.mapType = .satelliteFlyover    == section 2, row 3
     map.mapType = .standard            == section 2, row 4
     */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Some navigation Items
        if indexPath.section == 1 && indexPath.row == 0 {
            self.tabBarController?.selectedIndex = 2
        }
        
        if indexPath.section == 1 && indexPath.row == 1 {
            self.tabBarController?.selectedIndex = 1
        }
        
        // Settings
        if indexPath.section == 2 {
            
            // First de-select all
            tableView.cellForRow(at: IndexPath(row: 0, section: 2))?.accessoryType = .none
            tableView.cellForRow(at: IndexPath(row: 1, section: 2))?.accessoryType = .none
            tableView.cellForRow(at: IndexPath(row: 2, section: 2))?.accessoryType = .none
            tableView.cellForRow(at: IndexPath(row: 3, section: 2))?.accessoryType = .none
            tableView.cellForRow(at: IndexPath(row: 4, section: 2))?.accessoryType = .none
            
            // Determine which cell was chosen
            if let cell = tableView.cellForRow(at: indexPath) {
                if indexPath.row == 0 {
                    UserDefaults.standard.set("hybrid", forKey: "mapType")
                }
                
                if indexPath.row == 1 {
                    UserDefaults.standard.set("hybridFlyover", forKey: "mapType")
                }
                
                if indexPath.row == 2 {
                    UserDefaults.standard.set("satelite", forKey: "mapType")
                }
                
                if indexPath.row == 3 {
                    UserDefaults.standard.set("sateliteFlyover", forKey: "mapType")
                }
                
                if indexPath.row == 4 {
                    UserDefaults.standard.set("standard", forKey: "mapType")
                }
                
                cell.accessoryType = .checkmark
            }
        }
    }

}
