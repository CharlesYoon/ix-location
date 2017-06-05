//
//  SecondViewController.swift
//  ixLocation
//
//  Created by Miki von Ketelhodt on 2017/06/03.
//  Copyright © 2017 RBG Applications. All rights reserved.
//

import UIKit
import MapKit

class AppleMapsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, AddActivityDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManager: CLLocationManager!
    var currentUserLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // A region represents the area of the map that we want to view
        // It consists of a location (CLLocationCoordinate2D) and a Span (MKCoordinateSpanMak)
        let location = CLLocationCoordinate2D(latitude: -33.918861,longitude: 18.423300)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        // Always show the users location
        map.showsUserLocation = true

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        //locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
        
        setMapType()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setMapType()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMapType() {
        /*
         Different map types
         map.mapType = .hybrid
         map.mapType = .hybridFlyover
         map.mapType = .satellite
         map.mapType = .satelliteFlyover
         map.mapType = .standard
         */
        let mapType = UserDefaults.standard.string(forKey: "mapType")
        
        if mapType != nil {
            
            if mapType == "hybrid" {
                map.mapType = .hybrid
            }
            
            if mapType == "hybridFlyover" {
                map.mapType = .hybridFlyover
            }
            
            if mapType == "satellite" {
                map.mapType = .satellite
            }
            
            if mapType == "satelliteFlyover" {
                map.mapType = .satelliteFlyover
            }
            
            if mapType == "standard" {
                map.mapType = .standard
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addActivity" {
            // Create a new GeoPoint model based off of the current user location we receive
            let geopoint = GeoPoint(latitude: currentUserLocation.coordinate.latitude, longitude: currentUserLocation.coordinate.longitude)
        
            // Create a new activity that we want to pass to the next controller, containing the current location
            let activityWithCurrentLocation = Activity()
            activityWithCurrentLocation?.location = geopoint
        
            // Because we embedded our ViewController inside a Navigation Controller, we need to get it through the navigation controller
            let navigationController = segue.destination as! UINavigationController
            let addActivityViewController = navigationController.topViewController as! AddActivityViewController
            
            addActivityViewController.newActivity = activityWithCurrentLocation
            addActivityViewController.delegate = self
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Get the users location from the array of locations
        let userLocation: CLLocation = locations[0] as CLLocation
        
        // You can call stopUpdatingLocation() to stop listening for location updates
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        // Store reference to the users location in the class instance (self)
        self.currentUserLocation = userLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        // An error occurred trying to retrieve users location
        print("Error \(error)")
    }
    
    func mapView(_ mapView: MKMapView, didUpdate
        userLocation: MKUserLocation) {
        map.centerCoordinate = userLocation.location!.coordinate
    }
    
    func didSaveActivity(activity: Activity) {
        print(activity)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(activity.location.lat, activity.location.lng);
        annotation.title = activity.name
        map.addAnnotation(annotation)
    }
    
    func didCancelActivity() {
        
    }

}

