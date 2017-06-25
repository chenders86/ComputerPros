//
//  MenuCell.swift
//  ComputerPros
//
//  Created by Casey Henderson on 6/21/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import Foundation
import UIKit

class MenuCell: UICollectionViewCell {
    
    override var isHighlighted: Bool {
        didSet {
            
            backgroundColor = isHighlighted ? UIColor.white : UIColor.lightGray
            
            cellLabel.textColor = isHighlighted ? UIColor.lightGray : UIColor.white
            
            cellImage.tintColor = isHighlighted ? UIColor.lightGray : UIColor.white
        }
    }
    
    var setting: Setting? {
        didSet {
            
            cellLabel.text = setting?.name.rawValue
            
            if let imageName = setting?.imageName {
                cellImage.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                cellImage.tintColor = UIColor.white
            }
        }
    }
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
}
