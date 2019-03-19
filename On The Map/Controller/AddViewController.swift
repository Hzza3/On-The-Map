//
//  AddViewController.swift
//  On The Map
//
//  Created by Epic Systems on 3/10/19.
//  Copyright © 2019 EpicSystems. All rights reserved.
//

import UIKit
import CoreLocation

class AddViewController: UIViewController {
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Add Location"
        self.navigationItem.hidesBackButton = true
        let cancelButton = UIBarButtonItem(title: "CANCEL", style: .plain, target: self, action: #selector (dismissAddViewController(sender:)))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        activityIndicator.isHidden = true
        
    }
    
    @objc func dismissAddViewController(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func findLocationTapped(_ sender: Any) {
        
        if locationTextField.text == "" {
            showAlertWithMessage("Please Enter Location")
            return
        }
        if urlTextField.text == "" || UIApplication.shared.canOpenURL(URL(string: urlTextField.text!)!) == false {
            showAlertWithMessage("Please Enter your url ")
            return
        }
        
        let geoCoder = CLGeocoder()
        
        if let locationString = locationTextField.text {
            
            startAnimateActivityIndicator()
    
            geoCoder.geocodeAddressString(locationString) { (locationPlaceMarkers, error) in
                
                self.stopAnimatingActivityController()
                
                if error != nil {
                    
                    self.showAlertWithMessage("Invalid Location")
                    
                } else {
                    
                    if let placemarks = locationPlaceMarkers {
                        
                        if placemarks.count > 0 {
                            
                            guard let location: CLLocation = placemarks.first?.location else {return}
                            
                            let info = [
                                "uniqueKey" : UserData.shared().profileInfo.key,
                                "firstName" : UserData.shared().profileInfo.firstName,
                                "lastName" : UserData.shared().profileInfo.lastName,
                                "mapString" : self.locationTextField.text!,
                                "mediaURL" : self.urlTextField.text!,
                                "latitude" : location.coordinate.latitude,
                                "longitude" : location.coordinate.longitude
                                ] as [String : AnyObject]
                            
                            let dvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FindLocationViewController") as! FindLocationViewController
                            
                            dvc.location = location
                            dvc.studentInfo = StudentInformation(studentLocation: info)
                            self.navigationController?.pushViewController(dvc, animated: true)
                            
                        }
                    }
                }
            }
        }
    }
    
    func startAnimateActivityIndicator() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
    }
    
    func stopAnimatingActivityController() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
}
