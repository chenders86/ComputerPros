//
//  AppleTableViewCell.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/19/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import Foundation
import UIKit

class AppleTableViewCell: UITableViewCell {
    
    var displayInfo: ComputerDisplayProperties? {
        didSet {
            
            computerImage.image = displayInfo?.computerImage
            computerName.text = displayInfo?.displayName
        }
    }
    
    @IBOutlet weak var computerImage: UIImageView!
    @IBOutlet weak var computerName: UILabel!
}
