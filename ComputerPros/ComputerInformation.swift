//
//  ComputerInformationStruct.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/17/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import Foundation
import UIKit


class ComputerDisplayProperties: NSObject {
    
    var computerImage: UIImage?
    var displayName: String?
    var displayOrder: Int?
    var nodeName: String?
}

@objcMembers class DetailedComputerInfo: NSObject {
    
    // variable names are capitalized to match keys on server so to use "setValuesForKeys"
    
    var Color: String?
    var Name: String?
    var Price: String?
    var Processor: String?
    var Quantity: String?
    var RAM: String?
    var Storage: String?
    var DetailedImageURL: String?
    var ComputerImage: UIImage?
}
