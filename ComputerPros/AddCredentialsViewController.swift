//
//  AddCredentialsViewController.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/6/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import CoreData
import UIKit

class AddCredentialsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCredentialsView.layer.cornerRadius = 8
        addCredentialsView.layer.masksToBounds = true
        usernameTextfield.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        usernameTextfield.becomeFirstResponder()
    }
    
    var account: Account?
    
    let stack = CoreDataStack.sharedInstance()
    
    @IBOutlet weak var addCredentialsView: UIView!
    
    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var hiddenDismissButton: UIButton!

    @IBAction func dismissAddCredentialView(_ sender: Any) {
        usernameTextfield.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addCredentialsAndDismiss(_ sender: Any) {
       
        if usernameTextfield.text != "" && passwordTextField.text != "" {
            
            let cred = LoginCredentials(username: usernameTextfield.text, password: passwordTextField.text, context: stack.context)
            
            account?.addToLoginCredentials(cred)
            stack.save()
        
            usernameTextfield.resignFirstResponder()
            passwordTextField.resignFirstResponder()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension AddCredentialsViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if usernameTextfield.text == "" || passwordTextField.text == "" {
            return false
        } else {
            if usernameTextfield.text != "" && passwordTextField.text != "" {
                textField.resignFirstResponder()
                return true
            }
        }
        return false
    }
}
