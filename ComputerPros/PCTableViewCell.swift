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

    var computerInfo: ComputerInfo? {
        didSet {
            
            self.computerImage.image = computerInfo?.computerImage
            self.computerName.text = computerInfo?.name
        }
    }
    
    @IBOutlet weak var computerImage: UIImageView!
    @IBOutlet weak var computerName: UILabel!
}
