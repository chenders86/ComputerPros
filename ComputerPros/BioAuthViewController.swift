//
//  BioAuthViewController.swift
//  ComputerPros
//
//  Created by Casey Henderson on 4/22/18.
//  Copyright © 2018 Casey Henderson. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

class BioAuthViewController: UIViewController {
    
    let laContext = LAContext()
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visualEffectView.effect = UIBlurEffect(style: .light)
        
        laContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Unlock to view account info") { (success, error) in
            
            if success {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil) // Need to implement Error cases next.
                }
            }
        }
    }
}
