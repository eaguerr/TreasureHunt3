//
//  ViewController.swift
//  Treasure Hunt
//
//  Created by A.M. Student on 12/4/19.
//  Copyright © 2019 A.M. Student. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager?.delegate = self as? CLLocationManagerDelegate
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
    }
}

