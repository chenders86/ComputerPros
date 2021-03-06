//
//  PCTableViewCell.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/24/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import Foundation
import UIKit

class PCTableViewCell: UITableViewCell {

    var displayInfo: ComputerDisplayProperties? {
        didSet {
            
            computerImage.image = displayInfo?.computerImage
            computerName.text = displayInfo?.displayName
        }
    }
    
    @IBOutlet weak var computerImage: UIImageView!
    @IBOutlet weak var computerName: UILabel!
}
