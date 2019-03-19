//
//  ParseServices.swift
//  On The Map
//
//  Created by Epic Systems on 3/8/19.
//  Copyright © 2019 EpicSystems. All rights reserved.
//

import Foundation

class ParseServices {
    
    // MARK: Shared Instances
    static func shared() -> ParseServices {
        struct singlton {
            static var sharedInstance = ParseServices()
        }
        return singlton.sharedInstance
    }
    
    func postStudentLocation(studentInfo: StudentInformation, completion: @escaping (Bool, String?) -> Void) {
        
        let url = NetworkingTasks.shared().makeURLFromParameters(withPathExtension: ParseConstants.methods.studentsLocations, apiType: .parse)
        
        let jsonBody = "{\"uniqueKey\": \"\(studentInfo.uniqueKey)\", \"firstName\": \"\(studentInfo.firstName)\", \"lastName\": \"\(studentInfo.lastName)\", \"mapString\": \"\(studentInfo.mapString)\", \"mediaURL\": \"\(studentInfo.mediaURL)\", \"latitude\": \(studentInfo.latitude), \"longitude\": \(studentInfo.longitude)}"

        let _ = NetworkingTasks.shared().postTask(apiType: .parse, url: url, jsonBody: jsonBody) { (response, error) in
            
            if let error = error {
                
                completion(false, "\(error)")
                
            } else {
                
                if let createdAt = response?[ParseConstants.ParseAPIJSONResponseKeys.CreatedAt] as? String {
                    UserData.shared().locationCreatedAt = createdAt
                }
                
                if let objectId = response?[ParseConstants.ParseAPIJSONResponseKeys.ObjectID] as? String {
                    UserData.shared().objectId = objectId
                }
                completion(true, nil)
            }
        }
    }
    
    
    func getStudentsLocations(completion: @escaping (Bool, String?, [StudentInformation]?) -> Void) {
        
        let params = [
            "\(ParseConstants.ParseAPIParameterKeys.limit)" : 100,
            "\(ParseConstants.ParseAPIParameterKeys.order)" : "\(ParseConstants.ParseAPIJSONResponseKeys.UpdatedAt)"
            ] as [String : Any]
        let url = NetworkingTasks.shared().makeURLFromParameters(params as [String : AnyObject] , withPathExtension: ParseConstants.methods.studentsLocations, apiType: .parse)
        
        let _ = NetworkingTasks.shared().getTask(url: url, apiType: .parse) { (response, error) in
            
            if let error = error {
                
                completion(false, "\(error)", nil)
                
            } else {
                
                if let response = response {
                    
                    var locations = [StudentInformation]()
                    
                    if let responseArray = response[ParseConstants.ParseAPIJSONResponseKeys.locationsDict] as? [[String: AnyObject]] {
                        
                        for location in responseArray {
                            
                            let studentLocation = StudentInformation(studentLocation: location)
                           
                            locations.append(studentLocation)
                            
                        }
                      completion(true, nil, locations)
                    }
                }
            }
        }
    }
    
}
