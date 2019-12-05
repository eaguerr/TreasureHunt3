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
//        createAnnotations(locations: annotationLocations)
        centerOnUserLocation()
          }
          
        let locationManager = CLLocationManager()
    
//          let annotationLocations = [
//              ["title": "Riverside Cache", "latitude": 36.033846, "longitude": -95.981797],
//              ["title": "Peoria Cache", "latitude": 36.210999, "longitude": -95.976343],
//              ["title": "Broken Arrow Cache", "latitude": 36.003395, "longitude": -95.833936],
//              ["title": "Sand Springs Cache", "latitude": 36.138147, "longitude": 96.095937],
//              ["title": "Owasso Cache", "latitude": 36.314425, "longitude": 95.818798],
//              ["title": "Lemley Memorial Cache", "latitude": 36.113343, "longitude": 95.886945]
//          ]
    
    
    func centerOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 25000, longitudinalMeters: 25000)
            mapView.setRegion(region, animated: true)
            
        }
    }
          
//    func createAnnotations(locations: [[String : Any]]) {
//        for location in locations {
//            let annotations = MKPointAnnotation()
//            annotations.title = location["title"] as? String
//            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
//
//
//                  mapView.addAnnotation(annotations)
//        }
//    }
    
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
