//
//  Account+CoreDataProperties.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/5/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account");
    }

    @NSManaged public var accountName: String
    @NSManaged public var loginCredentials: NSSet?

}

// MARK: Generated accessors for loginCredentials
extension Account {

    @objc(addLoginCredentialsObject:)
    @NSManaged public func addToLoginCredentials(_ value: LoginCredentials)

    @objc(removeLoginCredentialsObject:)
    @NSManaged public func removeFromLoginCredentials(_ value: LoginCredentials)

    @objc(addLoginCredentials:)
    @NSManaged public func addToLoginCredentials(_ values: NSSet)

    @objc(removeLoginCredentials:)
    @NSManaged public func removeFromLoginCredentials(_ values: NSSet)

}
