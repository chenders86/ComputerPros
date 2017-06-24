//
//  MenuSettings.swift
//  ComputerPros
//
//  Created by Casey Henderson on 6/23/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import Foundation
import UIKit

class Setting: NSObject {
    
    let name: String
    let imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
