//
//  PasswordVCExtension.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/4/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import CoreData
import UIKit

extension PasswordViewController {
    
    func addHiddenButton() {
        
        self.view.addSubview(hiddenButton)
        print("Button Added")
        
        self.view.addConstraint(NSLayoutConstraint(item: hiddenButton, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: hiddenButton, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: hiddenButton, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: hiddenButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0))
    }
}
