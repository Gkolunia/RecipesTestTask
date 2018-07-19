//
//  SignInManager.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/13/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation

protocol UserSessionManagerProtocol {
    func isActiveUserSession() -> Bool
}

/**
 * @brief Singelton - for accessing of current signed user's session.
 */
class UserSessionManager : UserSessionManagerProtocol,  SignInManagerProtocol, LogoutManagerProtocol {
   
    static let shared = UserSessionManager()
    /**
     * @brief Try to do sign in.
     */
    func signIn(with signInCredetials: UserCredentials, completionHandler: (SingInResult) -> ()) {
        
        UserDefaults.standard.saveUserCredentials(signInCredetials)
        completionHandler(.success)
      
    }
    
    /**
     * @brief Do logout.
     */
    func logout() {
        UserDefaults.standard.removeLastUserCredentials()
    }
    
    /**
     * @brief To check if there is active user session.
     */
    func isActiveUserSession() -> Bool {
        if let _ = UserDefaults.standard.lastUserCredentials() {
            return true
        }
        else {
            return false
        }
    }
    
}
