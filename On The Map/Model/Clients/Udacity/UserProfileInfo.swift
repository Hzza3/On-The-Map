//
//  UserProfile.swift
//  On The Map
//
//  Created by Epic Systems on 3/12/19.
//  Copyright © 2019 EpicSystems. All rights reserved.
//

import Foundation

struct UserProfileInfo {
    
    var firstName: String
    var lastName: String
    var nickName: String
    var key: String
    var imgURL: String
    var email: String
    
    
    init(firstName:String = "", lastName:String = "", nickName: String = "", userKey: String = "", imgURL: String = "", email: String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.nickName = nickName
        self.key = userKey
        self.imgURL = imgURL
        self.email = email
    }
    
}
