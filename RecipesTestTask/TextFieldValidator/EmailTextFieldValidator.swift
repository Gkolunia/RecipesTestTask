//
//  EmailTextFieldValidator.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/14/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/**
 * @brief Validator for email text field
 */
class EmailTextFieldValidator : TextFieldValidator {
    
    private let regexString = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    
    override func validate(string: String?) -> Bool {
        guard let stringExist = string else {
            if let handler = handler {
                handler(false)
            }
            return false
        }
        
        let predic = NSPredicate.init(format: "SELF MATCHES %@", argumentArray: [regexString]);
        if predic.evaluate(with: stringExist) {
            textField.textColor = .green // Set green color if our email is valid
            if let handler = handler {
                handler(true)
            }
            return true
        }
        else {
            textField.textColor = .red // Set green color if our email is invalid
            if let handler = handler {
                handler(false)
            }
            return false
        }
       
    }
    
}
