//
//  FirstViewController.swift
//  ixLocation
//
//  Created by Miki von Ketelhodt on 2017/06/03.
//  Copyright © 2017 RBG Applications. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // A camera represents how we look at the map, where we are looking and how far in/out (zoom) we are looking at the map at
        let camera = GMSCameraPosition.camera(withLatitude: -33.918861, longitude: 18.423300, zoom: 8.0)
        
        // The MapView inherits from UIView and can be assigned to a UIView object. 
        // In our case, the entire view the controller manages
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

