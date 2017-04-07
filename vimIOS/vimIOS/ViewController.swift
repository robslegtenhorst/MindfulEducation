//
//  ViewController.swift
//  vimIOS
//
//  Created by Rob Slegtenhorst on 14/02/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textfield: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func testBTN(_ sender: UIButton) {
        textfield.text = "some text";
    }

}

