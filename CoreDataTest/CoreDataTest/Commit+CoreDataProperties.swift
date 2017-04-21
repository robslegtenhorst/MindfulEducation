//
//  Commit+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by Rob Slegtenhorst on 20/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Foundation
import CoreData


extension Commit {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Commit> {
        return NSFetchRequest<Commit>(entityName: "Commit")
    }

    @NSManaged public var message: String?
    @NSManaged public var date: Date?
    @NSManaged public var sha: String?
    @NSManaged public var url: String?

}
