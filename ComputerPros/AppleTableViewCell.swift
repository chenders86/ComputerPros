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
    
    var computerInfo: ComputerInfo? {
        didSet{
            
            computerImage.image = computerInfo?.computerImage
            computerName.text = computerInfo?.name
        }
    }
    
    @IBOutlet weak var computerImage: UIImageView!
    @IBOutlet weak var computerName: UILabel!
    
}
