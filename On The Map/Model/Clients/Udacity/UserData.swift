//
//  UserData.swift
//  On The Map
//
//  Created by Epic Systems on 3/5/19.
//  Copyright © 2019 EpicSystems. All rights reserved.
//

import Foundation

class UserData {
    
    static func shared() -> UserData {
        struct singlton {
            static let sharedInstance = UserData()
        }
        return singlton.sharedInstance
    }
    
    var profileInfo = UserProfileInfo()
    
    var userRegistered: AnyObject!
    var userKey: AnyObject!
    var sessionID: AnyObject!
    var expirationDate: AnyObject!
    
    var locationCreatedAt: String!
    var objectId: String!
    
    
}
