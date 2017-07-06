//
//  AddAccountViewController.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/4/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import CoreData
import UIKit

class AddAccountViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAccountView.layer.cornerRadius = 8
        addAccountView.layer.masksToBounds = true
        accountNameTextfield.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        accountNameTextfield.becomeFirstResponder()
    }
    
    let stack = CoreDataStack.sharedInstance()
    
    @IBOutlet weak var addAccountView: UIView!
    
    @IBOutlet weak var hiddenButton: UIButton!
    
    @IBOutlet weak var accountNameTextfield: UITextField!
    
    @IBAction func hiddenButtonPressed(_ sender: UIButton) {
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addAccountAndDismiss(_ sender: UIButton) {
        
        if accountNameTextfield.text != "" {
            let _ = Account(accountName: accountNameTextfield.text!, context: stack.context)
            stack.save()
            accountNameTextfield.resignFirstResponder()
            self.dismiss(animated: true, completion: nil)
        } else {
            return
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
