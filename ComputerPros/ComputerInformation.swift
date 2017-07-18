//
//  ComputerInformationStruct.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/17/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import Foundation
import UIKit

class ComputerInfo: NSObject {
    
    var name: String?
    var computerImage: UIImage?
    
}

class DetailedComputerInfo: NSObject {
    
    var imageURLString: String?
    var name: String?
    var processor: String?
    var storage: String?
    var ram: String?
    var color: String?
    var price: String?
    var quantity: String?
}
