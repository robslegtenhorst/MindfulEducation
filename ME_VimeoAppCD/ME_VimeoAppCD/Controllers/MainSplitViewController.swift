//
//  MainSplitViewController.swift
//  ME_VimeoAppCD
//
//  Created by Rob Slegtenhorst on 25/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Cocoa

class MainSplitViewController: NSSplitViewController {
    
    @IBOutlet weak var menuSplitView: NSSplitViewItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuSplitViewController = menuSplitView.viewController as! SidebarController
        menuSplitViewController.testCall()
        // Do view setup here.
    }
    
}
