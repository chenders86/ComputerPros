//
//  Account+CoreDataProperties.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/3/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account");
    }

    @NSManaged public var accountName: String
    @NSManaged public var loginCredentials: LoginCredentials?

}
