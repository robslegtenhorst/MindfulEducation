//
//  ScriptViewController.swift
//  ME_PartnerAdapt
//
//  Created by Rob Slegtenhorst on 07/04/2017.
//  Copyright © 2017 Rob Slegtenhorst. All rights reserved.
//

import Cocoa
import OAuth2
import Quartz

let OAuth2AppDidReceiveCallbackNotification = NSNotification.Name(rawValue: "OAuth2AppDidReceiveCallback")

class ScriptViewController: NSViewController {
    
    var nextActionForgetsTokens = false
    
    var loader: VimeoLoader = VimeoLoader();
    
    @IBOutlet var button: NSButton?
    @IBOutlet weak var signoutBtn: NSButton!
    
    @IBOutlet weak var contentField: NSTextField!
    
    @IBAction func forgetTokens(_ sender: NSButton?) {
        sender?.title = "Forgetting..."
        contentField?.stringValue = "Signing out..."
        loader.oauth2.forgetTokens()
        loader.oauth2.forgetClient()
        sender?.title = "Signed Out"
        button?.title = "Sign In"
        contentField?.stringValue = "Signed Out"
        contentField?.isHidden = false
        sender?.isEnabled = false
    }
    
    func handleRedirect(_ notification: Notification) {
        if let url = notification.object as? URL {
            contentField?.stringValue = "Handling redirect..."
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
    
    @IBAction func runBtn(_ sender: NSButton) {
        
        // show what is happening
        button?.title = "Authorizing..."
        button?.isEnabled = false
        
        // config OAuth2
        loader.oauth2.authConfig.authorizeContext = view.window
        NotificationCenter.default.removeObserver(self, name: OAuth2AppDidReceiveCallbackNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ScriptViewController.handleRedirect(_:)), name: OAuth2AppDidReceiveCallbackNotification, object: nil)
        
        // load user data
        loader.requestUserdata() { dict, error in
            if let error = error {
                switch error {
                case OAuth2Error.requestCancelled:
                    self.button?.title = "Cancelled. Try Again."
                default:
                    self.button?.title = "Failed. Try Again."
                    self.show(error)
                }
            }
            else {
                if let usrImgDict = dict?["pictures"] as? NSMutableDictionary {
                    
                    //let uri = usrImgDict["uri"] as! NSString;
                    let imgArray = usrImgDict["sizes"] as! NSArray;
                    
                    for i in 0 ..< imgArray.count
                    {
                        let dataDic = imgArray[i] as! NSMutableDictionary;
                        let width = dataDic["width"] as! NSNumber;
                        let link = dataDic["link"] as! NSString;
                        
                        if (width == 300)
                        {
                            let uri = link;
//                            self.image?.setImageWith(URL(string: uri as String)!)
                            print(uri)
                        }
                    }
                }
                if let username = dict?["name"] as? String {
                    self.contentField?.stringValue = "Hello there, \(username)!"
                }
                else {
                    self.contentField?.stringValue = "Failed to fetch your name"
                    NSLog("Fetched: \(dict)")
                }
                self.button?.title = "Run"
            }
            self.button?.isEnabled = true
            //            self.pasteButton?.isHidden = true
            self.signoutBtn.isHidden = false;
            self.contentField?.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (loader.oauth2.hasUnexpiredAccessToken() == true){
            self.button?.title = "Run"
            signoutBtn.isHidden = false;
        } else {
            self.button?.title = "Sign in"
            signoutBtn.isHidden = true;
        }
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
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
            contentField?.stringValue = error.localizedDescription
        }
        else {
            NSLog("Error authorizing: \(error.description)")
        }
    }

}
