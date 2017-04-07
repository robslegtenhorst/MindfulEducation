//
//  ScriptViewController.swift
//  ME_PartnerAdapt
//
//  Created by Rob Slegtenhorst on 07/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Cocoa

class ScriptViewController: NSViewController, XMLParserDelegate {
    
    @IBOutlet weak var contentField: NSTextField!
    
    @IBAction func runBtn(_ sender: NSButton) {
        contentField.stringValue = "test";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

}
