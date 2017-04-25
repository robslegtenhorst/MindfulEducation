//
//  ViewController.swift
//  ME_VimeoApp
//
//  Created by Rob Slegtenhorst on 11/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Cocoa
import OAuth2
import Quartz

let OAuth2AppDidReceiveCallbackNotification = NSNotification.Name(rawValue: "OAuth2AppDidReceiveCallback")

class LoginController: NSViewController {
    
    let center = NotificationCenter.default
    
    // TODO: remove logic from view

    @IBOutlet weak var loginBtn: NSButton!
    
    var loader : VimeoLoader!
    var parentView : MainViewController!
    
    func handleRedirect(_ notification: Notification) {
        if let url = notification.object as? URL {
            dismissViewController(self)
            parentView.logoutBtn.isEnabled = true
            parentView.logoutBtn.title = "Sign Out"
            
            center.post(name: NSNotification.Name(rawValue: Notifications.AppUserLogIn), object: nil)
//            parentView.startLoading()
            
            do {
                try loader.oauth2.handleRedirectURL(url)
            }
            catch let error {
                show(error)
            }
        }
        else {
            show(NSError(domain: NSCocoaErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid notification: did not contain a URL"]))
        }
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

    @IBAction func loginAction(_ sender: NSButton) {
        
        // config OAuth2
        NotificationCenter.default.removeObserver(self, name: OAuth2AppDidReceiveCallbackNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.handleRedirect(_:)), name: OAuth2AppDidReceiveCallbackNotification, object: nil)
        
        print(NotificationCenter.default.description)
        
        let button = sender
        
        // show what is happening
        button.title = "Authorizing..."
        button.isEnabled = false
        
        // load user data
        loader.requestInit() { dict, error in
            if let error = error {
                switch error {
                case OAuth2Error.requestCancelled:
                    button.title = "Cancelled. Try Again."
                default:
                    button.title = "Failed. Try Again."
                    self.show(error)
                }
            }
            else {
                NSLog("Fetched: \(dict)")
            }
            button.isEnabled = true
        }
    }
    
    @IBAction func quitApp(_ sender: NSButton) {
        dismissViewController(self)
        NSApplication.shared().terminate(self)
    }
    
    /** Forwards to `display(error:)`. */
    func show(_ error: Error) {
        if let error = error as? OAuth2Error {
            let err = NSError(domain: "OAuth2ErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: error.description])
            display(err)
        }
        else {
            display(error as NSError)
        }
    }
    
    /** Alert or log the given NSError. */
    func display(_ error: NSError) {
        if let window = self.view.window {
            NSAlert(error: error).beginSheetModal(for: window, completionHandler: nil)
//            contentField?.stringValue = error.localizedDescription
        }
        else {
            NSLog("Error authorizing: \(error.description)")
        }
    }

}

