//
//  TextFieldValidator.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/14/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/**
 * @brief Base Implementation for text feilds validators.
 */
class TextFieldValidator {
    
    weak var textField: UITextField!
    
    /**
     * @brief Call back event if we want to change something outside when valid status is changed.
     */
    var handler: ((_ isValid: Bool) -> ())?
    
    private var isValidStatus : Bool = false
    
    init(with textField: UITextField) {
        self.textField = textField
        addObserver()
    }
    
    @objc func textDidChange() {
        isValidStatus = validate(string: textField.text)
    }
    
    func isValid() -> Bool {
        return isValidStatus
    }
    
    func validate(string: String?) -> Bool {
        return isValidStatus
    }
    
    /**
     * @brief Observer changes of text field.
     */
    private func addObserver() {
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}
