//
//  StudentsLocations.swift
//  On The Map
//
//  Created by Epic Systems on 3/10/19.
//  Copyright © 2019 EpicSystems. All rights reserved.
//

import Foundation

class StudentsData {
    
    // MARK: Shared Instances
    static func shared() -> StudentsData {
        struct singlton {
            static var sharedInstance = StudentsData()
        }
        return singlton.sharedInstance
    }
    
    var StudentsLocations = [StudentInformation]()
    
    
}
