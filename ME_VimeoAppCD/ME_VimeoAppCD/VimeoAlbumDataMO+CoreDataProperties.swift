//
//  VimeoAlbumDataMO+CoreDataProperties.swift
//  ME_VimeoAppCD
//
//  Created by Rob Slegtenhorst on 21/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Foundation
import CoreData


extension VimeoAlbumDataMO {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<VimeoAlbumDataMO> {
        return NSFetchRequest<VimeoAlbumDataMO>(entityName: "VimeoAlbumDataMO")
    }

    @NSManaged public var uri: String?
    @NSManaged public var name: String?
    @NSManaged public var duration: Float
    @NSManaged public var link: String?
    @NSManaged public var created_time: NSDate?
    @NSManaged public var modified_time: NSDate?
    @NSManaged public var changed: Bool
    @NSManaged public var user_resource_key: String?

}
