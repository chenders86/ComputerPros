//
//  Account+CoreDataClass.swift
//  ComputerPros
//
//  Created by Casey Henderson on 7/3/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import Foundation
import CoreData

@objc(Account)
public class Account: NSManagedObject {

    convenience init(accountName: String, context: NSManagedObjectContext) {
        
        if let ent = NSEntityDescription.entity(forEntityName: "Account", in: context) {
            self.init(entity: ent, insertInto: context)
            self.accountName = accountName
        } else {
            fatalError()
        }
    }
}
