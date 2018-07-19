//
//  PasswordTextFieldValidator.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/14/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/**
 * @brief Validator for password text field. Just validate text field for valid password.
 */
class PasswordTextFieldValidator : TextFieldValidator {
    
    override func validate(string: String?) -> Bool {
        guard
            let string = string,
            let _ = string.rangeOfCharacter(from: NSCharacterSet.letters),
            let _ = string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) else {
                
                if let handler = handler {
                    handler(false)
                }
                textField.textColor = .red
                return false
        }
        
        textField.textColor = .green
        if let handler = handler {
            handler(true)
        }
        return true
        
    }
    
}
