//
//  VimeoData.swift
//  ME_VimeoApp
//
//  Created by Rob Slegtenhorst on 12/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Foundation
import OAuth2

struct VimeoData {
    
    let ALBUM = "ALBUM"
    let VIDEO = "VIDEO"
	
	let maxItems : CGFloat = 100;
	let tempMaxItems : CGFloat = 4;
	
    var albumTotal : CGFloat!
    var videoTotal : CGFloat!
    
    var albumPages : CGFloat!
    var videoPages : CGFloat!
    
    var videoDict : OAuth2JSON!
    var albumDict : OAuth2JSON!
    var userDict : OAuth2JSON!
    
    var vimeoUserData : VimeoUserData!
    
    var vimeoUserResource_key : String!
    
    var albumArray = Array<VimeoAlbumData>()
    var videoArray = Array<VimeoVideoData>()
    
    mutating func updatePagination (inputTotal: CGFloat, inputType : String)
    {
        switch inputType {
        case ALBUM:
            albumPages = ceil(inputTotal / maxItems);
        case VIDEO:
            videoPages = ceil(inputTotal / maxItems);
        default:
            return
        }
    }

}
