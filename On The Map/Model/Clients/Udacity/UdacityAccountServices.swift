//
//  UdacityAccountServices.swift
//  On The Map
//
//  Created by Epic Systems on 3/5/19.
//  Copyright © 2019 EpicSystems. All rights reserved.
//

import Foundation

class UdacityAccountServices {
    
    // MARK: Shared Instances
    static func shared() -> UdacityAccountServices {
        struct singlton {
            static var sharedInstance = UdacityAccountServices()
        }
        return singlton.sharedInstance
    }
    
    func createSession (userName: String, password: String, completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
        
        let url = NetworkingTasks.shared().makeURLFromParameters(withPathExtension: UdacityConstants.methods.session, apiType: .udacity)
        
        let jsonBody = "{\"\(UdacityConstants.UdacityAPIJSONBodyKeys.postSessionKey)\": {\"\(UdacityConstants.UdacityAPIJSONBodyKeys.userName)\": \"\(userName)\", \"\(UdacityConstants.UdacityAPIJSONBodyKeys.password)\": \"\(password)\"}}"
        
        
        let _ = NetworkingTasks.shared().postTask(apiType: .udacity, url: url, jsonBody: jsonBody) { (response, error) in
            
            if let error = error {
                
                completion(false, "\(error)")
                
            } else {
                
                if let responseAccountDictionary = response?[UdacityConstants.UdacityAPIJSONResponseKeys.accountDict] as? [String:AnyObject] {
                    
                    UserData.shared().userRegistered = responseAccountDictionary[UdacityConstants.UdacityAPIJSONResponseKeys.registered]
                    UserData.shared().userKey = responseAccountDictionary[UdacityConstants.UdacityAPIJSONResponseKeys.userKey]
                    
                }
                
                if let sessionSessionDictionary = response?[UdacityConstants.UdacityAPIJSONResponseKeys.sessionDict] as? [String:AnyObject] {
                    
                    UserData.shared().sessionID = sessionSessionDictionary[UdacityConstants.UdacityAPIJSONResponseKeys.sessionID]
                    UserData.shared().expirationDate = sessionSessionDictionary[UdacityConstants.UdacityAPIJSONResponseKeys.expirationDate]
                    
                }
                
                completion(true, nil)
            }
        }
    }
    
    func deleteSession (completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
        
        let url = NetworkingTasks.shared().makeURLFromParameters([:], withPathExtension: UdacityConstants.methods.session, apiType: .udacity)
        
        let _ = NetworkingTasks.shared().deleteTask(apiType: .udacity, url: url) { (response, error) in
            
            if let error = error {
                
                completion(false, "\(error)")
                
            } else {
                completion(true, nil)
            }
        }
    }
    
    func getUserInfo (completion: @escaping (_ success: Bool, _ error: String?) -> Void) {
        
        guard let userKey = UserData.shared().userKey else { return }
        let pathextension = UdacityConstants.methods.users + "/\(userKey)"
        
        let url = NetworkingTasks.shared().makeURLFromParameters([:], withPathExtension: pathextension, apiType: .udacity)

        let _ = NetworkingTasks.shared().getTask(url: url, apiType: .udacity) { (response, error) in
            
            if let error = error {
                completion(false, error)
            } else {
                if let response = response {
                    UserData.shared().profileInfo.firstName = response[UdacityConstants.UdacityAPIJSONResponseKeys.firstName] as! String
                    UserData.shared().profileInfo.lastName = response[UdacityConstants.UdacityAPIJSONResponseKeys.lastName] as! String
                    UserData.shared().profileInfo.nickName = response[UdacityConstants.UdacityAPIJSONResponseKeys.nickName] as! String
                    UserData.shared().profileInfo.key = response[UdacityConstants.UdacityAPIJSONResponseKeys.userKey] as! String
                    UserData.shared().profileInfo.imgURL = response[UdacityConstants.UdacityAPIJSONResponseKeys.imgURL] as! String
                    
                    if let email = response[UdacityConstants.UdacityAPIJSONResponseKeys.email] as? [String:AnyObject] {
                       UserData.shared().profileInfo.email = email[UdacityConstants.UdacityAPIJSONResponseKeys.emailAddress] as! String
                    }
                }
                completion(true, nil)
            }
        }
    }
}
