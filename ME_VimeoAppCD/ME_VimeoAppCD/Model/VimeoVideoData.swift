//
//  VimeoVideoData.swift
//  ME_VimeoApp
//
//  Created by Rob Slegtenhorst on 17/02/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Foundation

struct VimeoVideoData {
    var dataDic : NSDictionary!
    var uri : NSString = ""
    var name : NSString = ""
    var link : NSString = ""
    
    var duration : NSNumber = 0
    
    var width : NSNumber = 0
    var height : NSNumber = 0
    
    var created_time = NSDate()
    var modified_time = NSDate()
    var release_time = NSDate()
    
    // metadata > texttracks
    var texttracks_total : NSNumber = 0
    var texttracks_uri : NSString = "" // call this to get subs > https://developer.vimeo.com/api/playground/videos/211490127/texttracks
    
    var subtitle_url : NSString = ""
    
    // pictures > sizes
    var thumb_url_100x75 : NSString = ""
    var thumb_url_200x150 : NSString = ""
    var thumb_url_295x166 : NSString = ""
    var thumb_url_640x360 : NSString = ""
    var thumb_url_960x540 : NSString = ""
    var thumb_url_1280x720 : NSString = ""
    
    // stats
    var plays : NSNumber = 0
    
    // download (get 1080)
    var video_src_url_HD : NSString = ""
    var video_src_url_HD_created = NSDate()
    
    var video_src_url_Source : NSString = ""
    var video_src_url_Source_created = NSDate()
}
