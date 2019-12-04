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
