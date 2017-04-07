//
//  ViewController.swift
//  vimeoTest_2
//
//  Created by Rob Slegtenhorst on 14/02/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Cocoa
import VimeoNetworking

class ViewController: NSViewController {
    
    let appConfiguration = AppConfiguration(
        clientIdentifier: "Your client identifier goes here",
        clientSecret: "Your client secret goes here",
        scope: [.Public, .Private, .Interact]);

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func test_btn(_ sender: NSButton) {
        
    }

}

