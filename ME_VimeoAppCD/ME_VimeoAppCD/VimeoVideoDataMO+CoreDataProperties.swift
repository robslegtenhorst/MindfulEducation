//
//  VimeoVideoDataMO+CoreDataProperties.swift
//  ME_VimeoAppCD
//
//  Created by Rob Slegtenhorst on 21/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Foundation
import CoreData


extension VimeoVideoDataMO {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<VimeoVideoDataMO> {
        return NSFetchRequest<VimeoVideoDataMO>(entityName: "VimeoVideoDataMO")
    }

    @NSManaged public var uri: String?
    @NSManaged public var name: String?
    @NSManaged public var link: String?
    @NSManaged public var duration: Float
    @NSManaged public var width: Float
    @NSManaged public var height: Float
    @NSManaged public var created_time: NSDate?
    @NSManaged public var modified_time: NSDate?
    @NSManaged public var release_time: NSDate?
    @NSManaged public var texttracks_total: Float
    @NSManaged public var texttracks_uri: String?
    @NSManaged public var subtitle_url: String?
    @NSManaged public var thumb_url_100x75: String?
    @NSManaged public var thumb_url_200x150: String?
    @NSManaged public var thumb_url_295x166: String?
    @NSManaged public var thumb_url_640x360: String?
    @NSManaged public var thumb_url_960x540: String?
    @NSManaged public var thumb_url_1280x720: String?
    @NSManaged public var plays: Float
    @NSManaged public var video_src_url_HD: String?
    @NSManaged public var video_src_url_HD_created: NSDate?
    @NSManaged public var video_src_url_Source: String?
    @NSManaged public var video_src_url_Source_created: NSDate?
    @NSManaged public var resource_key: String?
    @NSManaged public var changed: Bool
    @NSManaged public var user_resource_key: String?
    @NSManaged public var video_src_url_HD_expires: NSDate?
    @NSManaged public var video_src_url_Source_expires: NSDate?

}
