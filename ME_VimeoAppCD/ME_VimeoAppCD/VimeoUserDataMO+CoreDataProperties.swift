//
//  VimeoUserDataMO+CoreDataProperties.swift
//  ME_VimeoAppCD
//
//  Created by Rob Slegtenhorst on 21/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Foundation
import CoreData


extension VimeoUserDataMO {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<VimeoUserDataMO> {
        return NSFetchRequest<VimeoUserDataMO>(entityName: "VimeoUserDataMO")
    }

    @NSManaged public var link: String?
    @NSManaged public var name: String?
    @NSManaged public var picture_30: String?
    @NSManaged public var picture_75: String?
    @NSManaged public var picture_100: String?
    @NSManaged public var picture_300: String?
    @NSManaged public var resource_key: String?
    @NSManaged public var uri: String?
    @NSManaged public var currentUser: Bool

}
