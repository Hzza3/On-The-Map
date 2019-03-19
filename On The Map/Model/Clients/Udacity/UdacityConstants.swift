//
//  OnTheMapConstants.swift
//  On The Map
//
//  Created by Epic Systems on 3/4/19.
//  Copyright © 2019 EpicSystems. All rights reserved.
//

import Foundation

struct UdacityConstants {
    
    // MARK: Methods
    struct methods {
        static let session =  "/session"
        static let users = "/users"
    }
    
    // MARK: URLs
    static let ApiScheme = "https"
    static let ApiHost = "onthemap-api.udacity.com"
    static let ApiPath = "/v1"
    
    static let udacitySignUpURL = "https://auth.udacity.com/sign-up"
    
    // Mark: Udacity API Parameter keys
    struct UdacityAPIParameterKeys {
        
    }
    
    // MARK: Udacity API JSON Body Keys
    struct UdacityAPIJSONBodyKeys {
        static let postSessionKey = "udacity"
        static let userName = "username"
        static let password = "password"
    }
    
    // MARK: Udacity API JSON Response Keys
    struct UdacityAPIJSONResponseKeys {
        
        static let accountDict = "account"
        static let registered = "registered"
        static let userKey = "key"
        static let sessionDict = "session"
        static let sessionID = "id"
        static let expirationDate = "expiration"
        
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let nickName = "nickname"
        static let imgURL = "_image_url"
        static let email = "email"
        static let emailAddress = "address"
    }
    
    // MARK: Udacity API JSON Header Keys
    struct UdacityAPIJsonHeaderKeys {
        static let ContentType = "Content-Type"
        static let Accept = "Accept"
    }
    
    // MARK: Udacity API JSON Header values
    struct UdacityAPIJsonHeaderValue {
        static let ContentType = "application/json"
        static let Accept = "application/json"
    }
}
