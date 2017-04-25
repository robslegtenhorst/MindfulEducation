//
//  FirstWindowController.swift
//  ME_VimeoAppCD
//
//  Created by Rob Slegtenhorst on 24/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Foundation
import Cocoa

class FirstWindowController : NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        window?.titleVisibility = .hidden
        window?.titlebarAppearsTransparent = true
        window?.styleMask.insert(.fullSizeContentView)
        
    }
}
