//
//  LoginCredentials+CoreDataProperties.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/5/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import Foundation
import CoreData


extension LoginCredentials {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoginCredentials> {
        return NSFetchRequest<LoginCredentials>(entityName: "LoginCredentials");
    }

    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var account: Account?

}
