//
//  StudentLocationInfo.swift
//  On The Map
//
//  Created by Epic Systems on 3/8/19.
//  Copyright © 2019 EpicSystems. All rights reserved.
//

import Foundation

struct StudentInformation {
    
    let objectID: String
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
   
    
    init(studentLocation: [String:AnyObject]) {
        
        self.objectID = studentLocation["objectId"] as? String ?? ""
        self.uniqueKey = studentLocation["uniqueKey"] as? String ?? ""
        self.firstName = studentLocation["firstName"] as? String ?? ""
        self.lastName = studentLocation["lastName"] as? String ?? ""
        self.mapString = studentLocation["mapString"] as? String ?? ""
        self.mediaURL = studentLocation["mediaURL"] as? String ?? ""
        self.latitude = studentLocation["latitude"] as? Double ?? 0.0
        self.longitude = studentLocation["longitude"] as? Double ?? 0.0
    
    }
}
