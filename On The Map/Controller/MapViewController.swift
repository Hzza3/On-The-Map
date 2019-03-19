//
//  MapViewController.swift
//  On The Map
//
//  Created by Epic Systems on 3/7/19.
//  Copyright © 2019 EpicSystems. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locations = [StudentInformation]()
    var annotations = [MKPointAnnotation]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTheMap()
    }
    
    func updateTheMap() {
        ParseServices.shared().getStudentsLocations { (success, error, fetchedStudentsData) in
            
            if success {
                if let studentsLocations = fetchedStudentsData {
                    StudentsData.shared().StudentsLocations = studentsLocations
                    self.locations = StudentsData.shared().StudentsLocations
                    performUIUpdatesOnMain {
                        self.makeAnnotations()
                    }
                }
            } else {
                performUIUpdatesOnMain {
                    self.showAlertWithMessage("Can not download students locations")
                }
            }
        }
    }
    
    func makeAnnotations() {
        
        for location in locations {
            
            let lat = CLLocationDegrees(location.latitude)
            let long = CLLocationDegrees(location.longitude)
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = location.firstName
            let last = location.lastName
            let mediaURL = location.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            annotations.append(annotation)
            
        }
        self.mapView.addAnnotations(annotations)
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                
                guard let url = URL(string: toOpen) else {return}
                app.open(url)
            }
        }
    }
    
}
