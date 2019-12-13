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
    @IBOutlet weak var addressLabel: UILabel!
    var previousLocation: CLLocation?
    let regionInMeters: Double = 25000
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
    
    override func viewDidLoad() {
          super.viewDidLoad()
        
        createAnnotations(locations: annotationLocations)
        centerOnUserLocation()
        
          }
    
    //Write Any Function Below
    func centerOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            //show alert
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTackingUserLocation()
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    func startTackingUserLocation() {
        mapView.showsUserLocation = true
        centerOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }

    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func getDirections() {
        guard let location = locationManager.location?.coordinate else {
            //Inform user we dont have their location
            return
        }
        
        let request = createDirectionsRequest(from: location)
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] (response, error) in
            //Handle error if needed
            guard let response = response else { return } //show response not available
            
            for route in response.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
            
        }
    }
    
    func createDirectionsRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let destinationCoordinate = getCenterLocation(for: mapView).coordinate
        let startingLocation = MKPlacemark(coordinate: coordinate)
        let destination = MKPlacemark(coordinate: destinationCoordinate)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startingLocation)
        request.destination = MKMapItem(placemark: destination)
        request.transportType = .walking
        request.requestsAlternateRoutes = false
        
        return request
    }
    
    func createAnnotations(locations: [[String : Any]]) {
        for location in locations {
            let annotations = MKPointAnnotation()
            annotations.subtitle = location["subtitle"] as? String
            annotations.title = location["title"] as? String
            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
            mapView.addAnnotation(annotations)
        }
    }
    
    // Write Any IBAction
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
    @IBAction func directionsButtonTapped(_ sender: UIButton) {
        getDirections()
    }
}


extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let _ = error {
                //TODO: Show alert informing the user
                return
            }
            
            guard let placemark = placemarks?.first else {
                //TODO: Show alert informing the user
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            
            DispatchQueue.main.async {
                self.addressLabel.text = "\(streetNumber) \(streetName)"
            }
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .blue
        
        return renderer
    }
}
