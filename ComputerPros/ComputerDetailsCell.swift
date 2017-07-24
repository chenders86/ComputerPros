//
//  ComputerDetailsCell.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/19/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import Foundation
import UIKit

class ComputerDetailsCell: UICollectionViewCell {
    
    var detailedComputerInfo: DetailedComputerInfo? {
        didSet {
            
            self.computerImageView.image = detailedComputerInfo?.ComputerImage
            setOptionalText()
            checkQuantity()
            //self.backgroundColor = UIColor.lightGray
        }
    }
    
    @IBOutlet weak var computerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var processorLabel: UILabel!
    @IBOutlet weak var ramLabel: UILabel!
    @IBOutlet weak var storageLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private func setOptionalText() {
        
        if let processor = detailedComputerInfo?.Processor {
            self.processorLabel.text =  "Processor: \(processor)"
        } else {
            self.processorLabel.text = "N/A"
        }
        
        if let name = detailedComputerInfo?.Name {
            self.nameLabel.text = name
        } else {
            self.nameLabel.text = "N/A"
        }
        
        if let ram = detailedComputerInfo?.RAM {
            self.ramLabel.text = "RAM: \(ram)"
        } else {
            self.ramLabel.text = "N/A"
        }
        
        if let storage = detailedComputerInfo?.Storage {
            self.storageLabel.text = "Storage: \(storage)"
        } else {
            self.storageLabel.text = "N/A"
        }
        
        if let color = detailedComputerInfo?.Color {
            self.colorLabel.text = "Color: \(color)"
        } else {
            self.colorLabel.text = "N/A"
        }
        
        if let quantity = detailedComputerInfo?.Quantity {
            self.quantityLabel.text = quantity
        } else {
            self.quantityLabel.text = "N/A"
        }
        
        if let price = detailedComputerInfo?.Price {
            self.priceLabel.text = "Price: \(price)"
        } else {
            self.priceLabel.text = "N/A"
        }
    }
    
    private func checkQuantity() {
        
        if quantityLabel.text == "0" {
            quantityLabel.textColor = UIColor.red
        } else if quantityLabel.text == "1" {
            quantityLabel.textColor = UIColor.orange
        } else {
            quantityLabel.textColor = UIColor.blue
        }
    }
}
