//
//  FirebaseClient.swift
//  ComputerPros
//
//  Created by Casey Henderson on 6/8/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import UIKit

class FirebaseClient: NSObject {
    
    func sharedInstance() -> FirebaseClient {
        
        struct Singleton {
            static var sharedInstance = FirebaseClient()
        }
        return Singleton.sharedInstance
    }
    
}
