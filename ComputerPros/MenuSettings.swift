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
    
    let name: MenuCellName
    let imageName: String
    
    init(name: MenuCellName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum MenuCellName: String {
    
    case Home = "Home"
    case ProCare = "ProCare Cloud"
    case Inventory = "Inventory"
    case Onsite = "On-Site"
    case Password = "Password Keeper"
    case Contact = "Contact Us"
}

enum ControllerIdentifier: String {
    
    case ProCareVC = "proCareVC"
    case InventoryVC = "inventoryVC"
    case PassWordVC = "passwordVC"
    case ContactVC = "contactVC"
    case WebVC = "webVC"
}

