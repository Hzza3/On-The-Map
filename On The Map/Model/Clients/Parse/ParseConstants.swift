//
//  ParseConstants.swift
//  On The Map
//
//  Created by Epic Systems on 3/4/19.
//  Copyright © 2019 EpicSystems. All rights reserved.
//

import Foundation

struct ParseConstants {
    
    
    // MARK: API Key
    static let ApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    static let ApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    
    // MARK: URLs
    static let ApiScheme = "https"
    static let ApiHost = "parse.udacity.com"
    static let ApiPath = "/parse/classes"
    
    // MARK: Methods
    struct methods {
        static let studentsLocations =  "/StudentLocation"
    }
    
    // MARK: Parse API Parameter Keys
    struct ParseAPIParameterKeys {
        
        static let limit = "limit"
        static let skip = "skip"
        static let order = "order"
    }
    
    // MARK: Parse API JSON Body Keys
    struct ParseAPIJSONBodyKeys {
    }
    
    // MARK: Parse API JSON Header Keys
    struct ParseAPIJsonHeaderKeys {
        static let ApplicationID = "X-Parse-Application-Id"
        static let APIKey = "X-Parse-REST-API-Key"
        static let ContentType = "Content-Type"
    }
    
    // MARK: Parse API JSON Header values
    struct ParseAPIJsonHeaderValue {
        static let ApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let APIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ContentType = "application/json"
    }
    
    // MARK: Parse API JSON Response Keys
    struct ParseAPIJSONResponseKeys {
        
        static let locationsDict = "results"
        
        static let ObjectID = "objectId"
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let CreatedAt = "createdAt"
        static let UpdatedAt = "-updatedAt"
        static let ACL = "ACL"
        
    }
    
    
}
