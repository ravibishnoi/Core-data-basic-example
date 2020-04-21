//
//  User+CoreDataProperties.swift
//  Core Data Learning
//
//  Created by AshutoshD on 26/03/20.
//  Copyright © 2020 ravindraB. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String

}
