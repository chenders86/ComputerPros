//
//  Extensions.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/20/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageUsingCacheWithURlString(urlString: String) {
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            
        }
    }
    
}
