//
//  AddAccountViewController.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/4/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import CoreData
import UIKit

class AddAccountViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAccountView.layer.cornerRadius = 8
        addAccountView.layer.masksToBounds = true
        
    }
    
    @IBOutlet weak var addAccountView: UIView!
    
    
    @IBAction func addAccountAndDismiss(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
