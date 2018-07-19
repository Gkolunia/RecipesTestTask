//
//  UserDefaults.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/12/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation

fileprivate struct UserDefaultsConstants {
    static let kUserCredentials = "kUserCredentials"
}

/**
 * @brief UserDefaults for saving user credentials. Just for convenience usage.
 */
extension UserDefaults {
    
    func lastUserCredentials() -> UserCredentials? {
        
        guard let encodedData = UserDefaults.standard.value(forKey: UserDefaultsConstants.kUserCredentials) as? Data else {
            return nil
        }
        
        guard let credentials = NSKeyedUnarchiver.unarchiveObject(with: encodedData) as? UserCredentials else {
            return nil
        }
        
        return credentials
    }
    
    func saveUserCredentials(_ credentials: UserCredentials) {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: credentials)
        UserDefaults.standard.setValue(encodedData, forKey: UserDefaultsConstants.kUserCredentials)
        UserDefaults.standard.synchronize()
    }
    
    func removeLastUserCredentials() {
        UserDefaults.standard.set(nil, forKey: UserDefaultsConstants.kUserCredentials)
        UserDefaults.standard.synchronize()
    }
    
}
