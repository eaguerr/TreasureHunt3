//
//  MapViewController.swift
//  Treasure Hunt
//
//  Created by A.M. Student on 12/4/19.
//  Copyright © 2019 A.M. Student. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
          super.viewDidLoad()
        
        createAnnotations(locations: annotationLocations)
        centerOnUserLocation()
        
          }
    let locationManager = CLLocationManager()
    
    let annotationLocations = [
        ["title": "Riverside Cache", "latitude": 36.033846, "longitude": -95.981797, "subtitle": "36.1370970,-96.0965250"],
        ["title": "Peoria Cache", "latitude": 36.210999, "longitude": -95.976343, "subtitle": "36.210999,-95.976343"],
        ["title": "Broken Arrow Cache", "latitude": 36.003395, "longitude": -95.833936, "subtitle": "36.003395,-95.833936"],
        ["title": "Sand Spring Cache", "latitude": 36.137097, "longitude": -96.096525, "subtitle": "36.137097,-96.096525"],
        ["title": "Lemley Memorial Cache", "latitude": 36.113433, "longitude": -95.886927, "subtitle": "36.113433,-95.886927"],
        ["title": "Gathering Place Cache", "latitude": 36.122296, "longitude": -95.985425, "subtitle": "36.122296,-95.985425"],
        ["title": "Owen Park Cache", "latitude": 36.160408, "longitude": -96.005639, "subtitle": "36.160408,-96.005639"],
        ["title": "Gilcrease Museum Cache", "latitude": 36.174719, "longitude": -96.020289, "subtitle": "36.174719,-96.020289"],
        ["title": "Dog Park Cache", "latitude": 36.016921, "longitude": -95.983280, "subtitle": "36.016921,-95.983280"],
        
    ]
          
    func createAnnotations(locations: [[String : Any]]) {
        for location in locations {
            let annotations = MKPointAnnotation()
            annotations.subtitle = location["subtitle"] as? String
            annotations.title = location["title"] as? String
            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
            mapView.addAnnotation(annotations)
        }
    }
    
    func centerOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 25000, longitudinalMeters: 25000)
            mapView.setRegion(region, animated: true)
            
        }
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func mapChanged(_ sender: UISegmentedControl) {
       if sender.selectedSegmentIndex == 0 || sender.selectedSegmentIndex == 1 || sender.selectedSegmentIndex == 2 {
              mapView.isHidden = false
              if sender.selectedSegmentIndex == 0 {
                mapView.mapType = .standard
              } else if sender.selectedSegmentIndex == 1 {
                mapView.mapType = .satellite
              } else if sender.selectedSegmentIndex == 2 {
                mapView.mapType = .hybrid
                }
            } else {
              mapView.isHidden = true
            }
        }
}
