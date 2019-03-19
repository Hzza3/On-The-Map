//
//  FindLocationViewController.swift
//  On The Map
//
//  Created by Epic Systems on 3/11/19.
//  Copyright © 2019 EpicSystems. All rights reserved.
//

import UIKit
import MapKit

class FindLocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var location = CLLocation()
    
    var studentInfo: StudentInformation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add Loacation"
        putPinPnTheMap()
    }
    
    
    @IBAction func finishTapped(_ sender: Any) {
        
        guard let locationInfo = studentInfo else { return }
        ParseServices.shared().postStudentLocation(studentInfo: locationInfo) { (success, error) in
            
            if success {
                performUIUpdatesOnMain {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            } else {
                performUIUpdatesOnMain {
                    self.showAlertWithMessage("can not add your location")
                }
            }
        }
        
    }
    
    
    
    func putPinPnTheMap() {
        
        let annotation = MKPointAnnotation()
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(self.location) { (placeMarkers, error) in
            if error != nil {
                self.showAlertWithMessage("Invalid Location")
            } else {
                guard let placeMark = placeMarkers?.first else { return }
                
                if let locationArea = placeMark.administrativeArea {
                    
                    annotation.title =  locationArea
                    
                }
                
                annotation.subtitle = self.studentInfo?.mediaURL
                annotation.coordinate = self.location.coordinate
                self.mapView.addAnnotation(annotation)
                self.mapView.showAnnotations(self.mapView.annotations, animated: true)
            }
        }
    }
    
}
