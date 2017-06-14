//
//  ActivityTableViewController.swift
//  ixLocation
//
//  Created by Miki von Ketelhodt on 2017/06/05.
//  Copyright © 2017 RBG Applications. All rights reserved.
//

import UIKit
import Alamofire
import Gloss
import Realm
import FirebaseStorage

class ActivityTableViewController: UITableViewController {

    var activities: [ActivityDto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        Alamofire.request("https://ixlocation.firebaseio.com/activities.json").responseJSON { response in
            //print(response.request)  // original URL request
            //print(response.response) // HTTP URL response
            //print(response.data)     // server data
            //print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                let response = JSON as! NSDictionary
                
                for (key, value) in response {
                    let activity = ActivityDto()
                    
                    if let actDictionary = value as? [String : AnyObject] {
                        activity?.name = actDictionary["name"] as! String
                        activity?.description = actDictionary["description"] as! String
                        
                        if let geoPointDictionary = actDictionary["location"] as? [String: AnyObject] {
                            let location = GeoPoint()
                            location.lat = geoPointDictionary["lat"] as? Double
                            location.lng = geoPointDictionary["lng"] as? Double
                            activity?.location = location
                        }
                    }
                    
                    self.activities.append(activity!)
                }
                
                self.tableView.reloadData()
                
                // Loop through activities and download images
                for activity in self.activities {
                    
                    let storageRef = Storage.storage().reference()
                
                    let imagesRef = storageRef.child("images/\(activity.name!).jpg")
                    
                    imagesRef.getData(maxSize: 10 * 1024 * 1024, completion: {(data, error) in
                        
                        if let error = error {
                            // Uh-oh, an error occurred!
                            print(error.localizedDescription)
                        } else {
                            // Data for "images/island.jpg" is returned
                            activity.image = UIImage(data: data!)
                            self.tableView.reloadData()
                        }
                        
                    })
                    
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(activities.count)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = activities[indexPath.row].name
        cell.detailTextLabel?.text = activities[indexPath.row].description
        
        if let image = activities[indexPath.row].image {
            cell.imageView?.image = image
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
