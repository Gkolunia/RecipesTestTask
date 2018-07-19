//
//  LoginViewController.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/11/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

enum SingInResult {
    case success
    case failure(Error)
}

/**
 * @brief Interface of object which does navigation from sign in controller
 */
protocol SignInDelegateProtocol : class {
    /**
     * @brief Method is called when ready to navigate from currrent sign in controller
     * @params controller - based on the controller push next controller
     */
    func signInControllerDidSignIn(_ controller: UIViewController)
    
    /**
     * @brief Pass error from current controller
     * @params error - error message
     * @params controller - pass current controller
     */
    func handle(_ error: Error, from controller: UIViewController)
}

/**
 * @brief Interface of object which does signIn process. It can be service manager for example.
 */
protocol SignInManagerProtocol : class {
    /**
     * @brief Called when we try to do signIn
     * @params signInCredetials - user credentials 
     * @params completionHandler - handler for handling response from the server or etc.
     */
    func signIn(with signInCredetials: UserCredentials, completionHandler: (SingInResult) -> ())
}


/**
 * @brief ViewController of signIn process
 */
class SignInViewController: UIViewController  {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    weak var delegate : SignInDelegateProtocol?
    var signInManager : SignInManagerProtocol!
    
    private var emailValidator : EmailTextFieldValidator!
    private var passwordValidator : PasswordTextFieldValidator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateTextFields()
        signInButton.isEnabled = false // Sign in button default state is disabled
        NotificationCenter.default.addObserver(self, selector: #selector(signInOnClick), name: NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object: nil)
    }
    
    private func configurateTextFields() {
        
        emailValidator = EmailTextFieldValidator(with: emailTextField)
        passwordValidator = PasswordTextFieldValidator(with: passwordTextField)
        
        emailValidator.handler = {[unowned self] (isValid) -> () in
            if isValid {
                self.signInButton.isEnabled = self.passwordValidator.isValid() // Sign in button should be valid when both fields are correct
            }
            else {
                self.signInButton.isEnabled = false
            }
        }
        
        passwordValidator.handler = {[unowned self] (isValid) -> () in
            if isValid {
                self.signInButton.isEnabled = self.emailValidator.isValid() // Sign in button should be valid when both fields are correct
            }
            else {
                self.signInButton.isEnabled = false
            }
        }
        
    }

    @IBAction func signInOnClick(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            fatalError()
        }
        
        view.endEditing(true)
        signInManager.signIn(with: UserCredentials(email, password)) { (result) in
            switch result {
            case .success:
                delegate?.signInControllerDidSignIn(self)
            case .failure(let error):
                delegate?.handle(error, from: self)
            }
        }
        
    }

}
