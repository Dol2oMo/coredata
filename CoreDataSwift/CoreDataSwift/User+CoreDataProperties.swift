//
//  User+CoreDataProperties.swift
//  CoreDataSwift
//
//  Created by MC-MG57035 on 9/11/2560 BE.
//  Copyright © 2560 Dol2oMo. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var user_id: Int16
    @NSManaged public var user_name: String?

}
