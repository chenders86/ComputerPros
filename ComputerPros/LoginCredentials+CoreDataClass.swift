//
//  LoginCredentials+CoreDataClass.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/3/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import Foundation
import CoreData

@objc(LoginCredentials)
public class LoginCredentials: NSManagedObject {
    
    convenience init(username: String?, password: String?, context: NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entity(forEntityName: "LoginCredentials", in: context) {
            self.init(entity: ent, insertInto: context)
            self.username = username
            self.password = password
        } else {
            fatalError()
        }
    }
}
