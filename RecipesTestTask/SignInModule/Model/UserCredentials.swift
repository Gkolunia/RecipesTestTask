//
//  UserCredentials.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/12/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation

/**
 * @brief Model which is saved into user defaults when user is signed in
 */
class UserCredentials : NSObject, NSCoding {
    
    let email: String
    let password: String
    
    init(_ emailDefault: String, _ passwordDefault: String) {
        email = emailDefault
        password = passwordDefault
    }
    
    public required init?(coder aDecoder: NSCoder) {
        email = aDecoder.decodeObject(forKey: "email") as! String
        password = aDecoder.decodeObject(forKey: "password") as! String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(email, forKey: "email")
        aCoder.encode(password, forKey: "password")
    }
    
}
