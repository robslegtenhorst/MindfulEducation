//
//  VimeoData.swift
//  ME_PartnerAdapt
//
//  Created by Rob Slegtenhorst on 17/02/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Foundation

struct VimeoData {
    var dataDic : NSDictionary;
    var name : NSString;
    var link : NSString;
    var texttracks_total : NSNumber;
    
    var duration : NSNumber;
    
    var created_time : NSString;
    var modified_time : NSString;
    var release_time : NSString;
    
    var subtitle_url : NSString;
    
    var downloadLink : NSString;
    
    var albumID:NSString;
    var videoType:String;
    
    var complete : Bool;
}
